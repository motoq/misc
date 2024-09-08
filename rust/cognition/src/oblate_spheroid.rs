/*
 * Copyright 2024 Kurt Motekew
 *
 * This Source Code Form is subject to the terms of the Mozilla Public
 * License, v. 2.0. If a copy of the MPL was not distributed with this
 * file, You can obtain one at http://mozilla.org/MPL/2.0/.
 */

/**
 * Oblate spheroid definition (eccentricity and semimajor axis length)
 * and coordinates (oblate spheroidal and Cartesian) struct.
 */
pub struct OblateSpheroid {
    eccen: f64,
    smajor: f64,
    lambda: f64,
    eta: f64,
    cart: [f64; 3],
}

const DPR: f64 = 180.0/std::f64::consts::PI;

/**
 * OblateSpheroid creation functionality
 */
impl OblateSpheroid {
    /**
     * Create OblateSpheroid and set coordinates
     *
     * @param  eccen   Eccentricity defining parameter, 0 <= eccen < 1
     * @param  smajor  Semimajor axis defining parameter, smajor > 0
     * @param  lambda  Longitude/Azimuth coordinate, -pi/2 < lambda < pi/2
     * @param  eta     Latitude/elevation coordinate, -1 <= eta <= 1 
     *
     * @return  Ok:  OblateSpheroid
     *          Err: String
     */
    pub fn new(eccen: f64,
               smajor: f64,
               lambda: f64,
               eta: f64) -> Result<OblateSpheroid, String> {
        if eccen < 0.0   ||  eccen >= 1.0 {
            return Err("Invalid Eccentricity: ".to_string() +
                        &eccen.to_string());
        } else if smajor < 0.0 {
            return Err("Invalid Semimajor Axis: ".to_string() +
                       &smajor.to_string());
        } else if lambda < -0.5*std::f64::consts::PI  ||
                  lambda >  0.5*std::f64::consts::PI {
            return Err("Invalid Azimuth: ".to_string() +
                       &(DPR*lambda).to_string());
        } else if eta < -1.0  ||  eta >  1.0 {
            return Err("Invalid Elevation: ".to_string() +
                       &eta.to_string());
        }
        // Set OS def and coords, then update Cartesian
        let mut os = OblateSpheroid {eccen,
                                     smajor,
                                     lambda,
                                     eta,
                                     cart: Default::default(),
        };
        os.set_with_os(eccen, smajor, lambda, eta);
        Ok(os)
    }

    /*
     * Update Cartesian coords with previously validated OS coords 
     */
    fn set_with_os(&mut self, ecc: f64, sma: f64, lam: f64, eta: f64) {
        let sqometa2 = (1.0 - eta*eta).sqrt();

        self.cart[0] = sma*sqometa2*lam.cos();
        self.cart[1] = sma*sqometa2*lam.sin();
        self.cart[2] = sma*eta*(1.0 - ecc*ecc).sqrt();
    }
}

impl Default for OblateSpheroid {
    /**
     * Default oblate spheroid definition and coordinates
     *
     * @return  Point sphere with location at origin
     */
    fn default() -> Self {
        Self {
            eccen: 0.0,
            smajor: 0.0,
            lambda: 0.0,
            eta: 0.0,
            cart: [0.0, 0.0, 0.0],
        }
    }
}


impl std::fmt::Display for OblateSpheroid {
    /**
     * @return  Printable form of OblateSpheroid
     */
    fn fmt(&self, f: &mut std::fmt::Formatter) -> std::fmt::Result {
        write!(f, "(\n  Eccentricity: {};  Semimajor: {}\
                   ;  Lambda: {};  Eta: {})",
            self.eccen, self.smajor, DPR*self.lambda, self.eta)
    }
}

