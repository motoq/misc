
#[derive(Default)]
pub struct OblateSpheroid {
    eccen: f64,
    smajor: f64,
    lambda: f64,
    eta: f64,
}


impl OblateSpheroid {
    pub fn new(eccen: f64, smajor: f64, lambda: f64, eta: f64) -> Self {
        Self {
            eccen,
            smajor,
            lambda,
            eta,
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

