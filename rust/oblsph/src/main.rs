use std::io;

use cognition::oblate_spheroid;

fn main() {

    const RAD_PER_DEG: f64 = std::f64::consts::PI/180.0;

    // Get Inputs
    println!("Enter the eccentricity (0 <= e < 1):");
    let eccen: f64 = read_input();
    println!("Enter the semimajor axis length (0 <= a):");
    let smajor: f64 = read_input();
    println!("Enter longitude (-180 <= lam <= 180):");
    let lambda: f64  = RAD_PER_DEG*read_input();
    println!("Enter elevation (-1 <= eta <= 1):");
    let eta: f64 = read_input();

    let os = if let Ok(os) =
        oblate_spheroid::OblateSpheroid::new(eccen, smajor, lambda, eta) {
        os
    } else {
        println!("Bad OblateSpheroid Init");
        return;
    };

    println!("OblateSpheroid {}", os);

    let os: oblate_spheroid::OblateSpheroid  = Default::default();
    println!("OblateSpheroid {}", os);

    println!("\n");
}


fn read_input() -> f64 {
    let ret_val = loop {
        let mut str_val = String::new();
        io::stdin()
            .read_line(&mut str_val)
            .expect("Failed to read input from command line!");
        let val = match str_val.trim().parse() {
            Ok(num) => num,
            Err(_) => continue,
        };
        break val;
    };

    ret_val
}


/*
 * Requests user input from the CL.  A single f64 with the given limits
 * is returned.  The function will continue to ask for a value until a
 * valid one is entered.
 *
 * @param  min_val  Minimum allowable value
 * @param  max_val  Maximum allowable value
 *
 * @return  Parsed value meeting requirements
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
 */


