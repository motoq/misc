
pub struct OblateSpheroid {
    eccen: f64,
    smajor: f64,
    lambda: f64,
    eta: f64,
    cart: [f64; 3],
}


impl OblateSpheroid {
    pub fn new(eccen: f64,
               smajor: f64,
               lambda: f64,
               eta: f64) -> Result<OblateSpheroid, String> {
        if eccen < 0.0   ||  eccen >= 1.0 {
            return Err("Invalid Eccentricity".to_string());
        } else if smajor < 0.0 {
            return Err("Invalid Semimajor Axis".to_string());
        } else if lambda < -0.5*std::f64::consts::PI  ||
                  lambda >  0.5*std::f64::consts::PI {
            return Err("Invalid Azimuth".to_string());
        } else if eta < -1.0  ||  eta >  1.0 {
            return Err("Invalid Elevation".to_string());
        }
        let mut os = OblateSpheroid {eccen,
                                     smajor,
                                     lambda,
                                     eta,
                                     cart: Default::default(),
        };
        os.set_with_os(eccen, smajor, lambda, eta);
        Ok(os)
    }

    fn set_with_os(&mut self, ecc: f64, sma: f64, lam: f64, eta: f64) {
        let sqometa2 = (1.0 - eta*eta).sqrt();

        self.cart[0] = sma*sqometa2*lam.cos();
        self.cart[1] = sma*sqometa2*lam.sin();
        self.cart[2] = sma*eta*(1.0 - ecc*ecc).sqrt();
    }
}

impl Default for OblateSpheroid {
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
    fn fmt(&self, f: &mut std::fmt::Formatter) -> std::fmt::Result {
        const DPR: f64 = 180.0/std::f64::consts::PI;
        write!(f, "(\n  Eccentricity: {};  Semimajor: {}\
                   ;  Lambda: {};  Eta: {})",
            self.eccen, self.smajor, DPR*self.lambda, self.eta)
    }
}

