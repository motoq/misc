
#[derive(Default)]
pub struct OblateSpheroid {
    m_eccen: f64,
    m_smajor: f64,
    m_lambda: f64,
    m_eta: f64,
}


impl OblateSpheroid {
    pub fn new(eccen: f64, smajor: f64, lambda: f64, eta: f64) -> Self {
        Self {
            m_eccen: eccen,
            m_smajor: smajor,
            m_lambda: lambda,
            m_eta: eta,
        }
    }
}


impl std::fmt::Display for OblateSpheroid {
    fn fmt(&self, f: &mut std::fmt::Formatter) -> std::fmt::Result {
        const DPR: f64 = 180.0/std::f64::consts::PI;
        write!(f, "(\n  Eccentricity: {};  Semimajor: {}\
                   ;  Lambda: {};  Eta: {})",
            self.m_eccen, self.m_smajor, DPR*self.m_lambda, self.m_eta)
    }
}

