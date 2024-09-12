use std::io;

use cognition::oblate_spheroid;

fn main() {
    // Get inputs from command line
    println!("Enter the eccentricity (0 <= e < 1):");
    let eccen: f64 = read_input();
    println!("Enter the semimajor axis length (0 <= a):");
    let smajor: f64 = read_input();
    println!("Enter longitude (-180 <= lon <= 180):");
    let lon: f64  = (std::f64::consts::PI/180.0)*read_input();
    println!("Enter elevation (-1 <= lat <= 1):");
    let lat: f64 = read_input();

    let os = oblate_spheroid::OblateSpheroid::new(eccen, smajor, lon, lat)
                 .expect("OblateSpheroid Construction: ");

    println!("OblateSpheroid {}", os);

    println!("\n");
}


/**
 * Requests user input from the CL for a number.
 * The function will continue to ask for a value until an
 * entry that can be interpreted as a number is entered.
 *
 * @return  Parsed value
 */
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
    let os = match oblate_spheroid::OblateSpheroid::new(eccen,
                                                        smajor, lambda, eta) {
        Ok(ok) => ok,
        Err(error) => panic!("OblateSpheroid Construction: {error:?}"),
    println!("OblateSpheroid {}", os);
    let os: oblate_spheroid::OblateSpheroid  = Default::default();
    println!("OblateSpheroid {}", os);
    };
    */

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


