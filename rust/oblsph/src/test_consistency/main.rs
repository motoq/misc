use cognition::oblate_spheroid;

fn main() {
    const RPD: f64 = std::f64::consts::PI/180.0;

    let mut ecc: f64 = 0.0;
    let mut sma: f64 = 0.1;
    let mut lon: f64 = RPD*-180.0;
    let mut lat: f64 = -0.9;
    let decc: f64 = 0.01;
    let dsma: f64 = 0.01;
    let dlon: f64 = RPD*3.0;
    let dlat: f64 = 0.01;

    let mut count = 0;
    let mut rss_error: f64  = 0.0;
    while ecc < 0.9 {
        while sma < 7.5 {
            while lat < 0.9 {
                while lon < RPD*180.0 {
                    let os1 =
                            oblate_spheroid::
                            OblateSpheroid::new(ecc, sma, lon, lat)
                            .expect("OblateSpheroid Construction: ");
                    let xyz = os1.get_cartesian();
                    let os2 =
                            oblate_spheroid::
                            OblateSpheroid::new_from_cartesian(ecc, &xyz)
                            .expect("OblateSpheroid Construction: ");
        
                    let de = os2.get_eccentricity() - os1.get_eccentricity();
                    let da = os2.get_semimajor() - os1.get_semimajor();
                    let dn = os2.get_longitude() - os1.get_longitude();
                    let dt = os2.get_latitude() - os1.get_latitude();
                    rss_error += (de*de + da*da + dn*dn + dt*dt).sqrt();
                    count += 1;
        
                    lon += dlon;
                }
                lat += dlat;
            }
            sma += dsma;
        }
        ecc += decc;
    }
    println!("RSS Error over {} tests: {}", count, rss_error);
}
