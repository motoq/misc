/*
 * Copyright 2024 Kurt Motekew
 *
 * This Source Code Form is subject to the terms of the Mozilla Public
 * License, v. 2.0. If a copy of the MPL was not distributed with this
 * file, You can obtain one at http://mozilla.org/MPL/2.0/.
 */

extern crate nalgebra as na;

use crate::utl_const::DEG_PER_RAD;


/**
 * Oblate spheroid definition (eccentricity and semimajor axis length)
 * and coordinates (oblate spheroidal and Cartesian) struct.
 */
pub struct OblateSpheroid {
    ecc: f64,
    sma: f64,
    lon: f64,
    lat: f64,
    xyz: na::SMatrix<f64, 3, 1>,
}


/**
 * OblateSpheroid associated functions for instantiation
 */
impl OblateSpheroid {
    /**
     * Create OblateSpheroid and set coordinates
     *
     * @param  eccentricity  Eccentricity defining parameter, 0 <= eccen < 1
     * @param  semimajor     Semimajor axis defining parameter, smajor > 0
     * @param  longitude     Longitude/Azimuth coordinate, -pi/2 < lambda < pi/2
     * @param  latitude      Latitude/elevation coordinate, -1 <= eta <= 1 
     *
     * @return  Ok:  OblateSpheroid
     *          Err: String
     */
    pub fn new(eccentricity: f64,
               semimajor: f64,
               longitude: f64,
               latitude: f64) -> Result<OblateSpheroid, String> {
        if eccentricity < 0.0   ||  eccentricity >= 1.0 {
            return Err("Invalid Eccentricity: ".to_string() +
                        &eccentricity.to_string());
        } else if semimajor < 0.0 {
            return Err("Invalid Semimajor Axis: ".to_string() +
                       &semimajor.to_string());
        } else if longitude < -std::f64::consts::PI  ||
                  longitude >  std::f64::consts::PI {
            return Err("Invalid Longitude: ".to_string() +
                       &(DEG_PER_RAD*longitude).to_string());
        } else if latitude < -1.0  ||  latitude >  1.0 {
            return Err("Invalid Latitude: ".to_string() +
                       &latitude.to_string());
        }
        // Set OS def and coords, then update Cartesian
        let mut os = OblateSpheroid {ecc: eccentricity,
                                     sma: semimajor,
                                     lon: longitude,
                                     lat: latitude,
                                     xyz: Default::default()
        };
        os.set_with_os(eccentricity, semimajor, longitude, latitude);
        Ok(os)
    }

    /**
     * Create OblateSpheroid and set coordinates given a location in
     * Cartesian coordinates
     *
     * @param  eccentricity  Eccentricity defining parameter, 0 <= eccen < 1
     * @param  xyz           Cartesian coordinates
     *
     * @return  Ok:  OblateSpheroid
     *          Err: String
     */
    pub fn new_from_cartesian(eccentricity: f64,
                              cartesian: &na::SMatrix<f64, 3, 1>)
               -> Result<OblateSpheroid, String> {
        if eccentricity < 0.0   ||  eccentricity >= 1.0 {
            return Err("Invalid Eccentricity: ".to_string() +
                        &eccentricity.to_string());
        }
        // Set OS def and coords, then update Cartesian
        let mut os = OblateSpheroid {ecc: eccentricity,
                                     sma: Default::default(),
                                     lon: Default::default(),
                                     lat: Default::default(),
                                     xyz: *cartesian,
        };
        os.set_with_cartesian(eccentricity, cartesian);
        Ok(os)
    }
}


/**
 * Public immutable methods
 */
impl OblateSpheroid {
    /**
     * @return  Eccentricity
     */
    pub fn get_eccentricity(&self) -> f64 {
        self.ecc
    }


    /**
     * @return  Semimajor axis
     */
    pub fn get_semimajor(&self) -> f64 {
        self.sma
    }


    /**
     * @return  Longitude, radians
     */
    pub fn get_longitude(&self) -> f64 {
        self.lon
    }


    /**
     * @return  Latitude
     */
    pub fn get_latitude(&self) -> f64 {
        self.lat
    }


    /**
     * @return  Cartesian coordinates
     */
    pub fn get_cartesian(&self) -> na::SMatrix<f64, 3, 1> {
        self.xyz
    }
}


/**
 * Private methods
 */
impl OblateSpheroid {

    //
    // Private Functions
    //

    /*
     * Update Cartesian coords with previously validated OS coords
     *
     * @param  eccen  Eccentricity defining parameter, 0 <= eccen < 1
     * @param  smaj   Semimajor axis defining parameter, smajor > 0
     * @param  lam    Longitude/Azimuth coordinate, -pi/2 < lambda < pi/2
     * @param  eta    Latitude/elevation coordinate, -1 <= eta <= 1 
     */
    fn set_with_os(&mut self, eccen: f64, smaj: f64, lam: f64, eta: f64) {
        let sqometa2 = (1.0 - eta*eta).sqrt();

        self.xyz[0] = smaj*sqometa2*lam.cos();
        self.xyz[1] = smaj*sqometa2*lam.sin();
        self.xyz[2] = smaj*eta*(1.0 - eccen*eccen).sqrt();
    }


    /*
     * Update OS coords with Cartesian
     *
     * @param  eccen  Eccentricity defining parameter, 0 <= eccen < 1
     * @param  cart   Cartesian coordinates
     */
    fn set_with_cartesian(&mut self, eccen: f64,
                          cart: &na::SMatrix<f64, 3, 1>) {
        let x2y2 = cart[0]*cart[0] + cart[1]*cart[1];
        let z2 = cart[2]*cart[2];
        let ome2 = 1.0 - eccen*eccen;

        self.sma = (x2y2 + z2/ome2).sqrt();
        self.lon = cart[1].atan2(cart[0]);
        self.lat = cart[2]/(self.sma*ome2.sqrt());
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
            ecc: 0.0,
            sma: 0.0,
            lon: 0.0,
            lat: 0.0,
            xyz: [0.0, 0.0, 0.0].into(),
        }
    }
}


impl std::fmt::Display for OblateSpheroid {
    /**
     * @return  Printable form of OblateSpheroid
     */
    fn fmt(&self, f: &mut std::fmt::Formatter) -> std::fmt::Result {
        write!(f, "(Eccentricity: {};  Semimajor: {}\
                   ;  Azimuth: {};  Elevation: {})",
            self.ecc, self.sma, DEG_PER_RAD*self.lon, self.lat)
    }
}

