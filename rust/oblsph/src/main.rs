use std::io;

use cognition::oblate_spheroid::OblateSpheroid;

fn main() {

    let mut os: OblateSpheroid = Default::default();

    const RAD_PER_DEG: f64 = std::f64::consts::PI/180.0;
    const DEG_PER_RAD: f64 = 1.0/RAD_PER_DEG;

    let max_smaj = f64::sqrt(0.1*std::f64::MAX);

    println!("Enter the eccentricity (0 <= e < 1):");
    os.eccen = obls_read_input(0.0, 0.9);

    println!("Enter the semimajor axis length (0 <= a):");
    os.smajor = obls_read_input(0.0, max_smaj);

    println!("Enter longitude (-180 <= lam <= 180):");
    os.lambda = RAD_PER_DEG*obls_read_input(-180.0, 180.0);

    println!("Enter elevation (-1 <= eta <= 1):");
    os.eta = obls_read_input(-1.0, 1.0);

    println!("\n");
    println!("Eccentricity:    {}", os.eccen);
    println!("Semimajor axis:  {}", os.smajor);
    println!("Longitude:      {} deg", DEG_PER_RAD*os.lambda);
    println!("Elevation:       {}", os.eta);
}


/**
 * Requests user input from the CL.  A single f64 with the given limits
 * is returned.  The function will continue to ask for a value until a
 * valid one is entered.
 *
 * @param  min_val  Minimum allowable value
 * @param  max_val  Maximum allowable value
 *
 * @return  Parsed value meeting requirements
 */
fn obls_read_input(min_val: f64, max_val: f64) -> f64 {

    let mut bad_val = 2.0*max_val;
      // Account for min and max being less than zero
    if max_val < 0.0 {
        bad_val = 2.0*min_val;
    }

    let ret_val = loop {
        let mut str_val = String::new();
        io::stdin()
            .read_line(&mut str_val)
            .expect("Failed to read input from command line!");
        let val = match str_val.trim().parse() {
            Ok(num) => num,
            Err(_) => bad_val,
        };
        if !(val < min_val  ||  val > max_val) {
            break val;
        }
    };

    ret_val
}


