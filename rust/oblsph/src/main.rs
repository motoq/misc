use std::io;

fn main() {
    const RAD_PER_DEG: f64 = std::f64::consts::PI/180.0;
    const DEG_PER_RAD: f64 = 1.0/RAD_PER_DEG;

    let max_smaj = f64::sqrt(0.1*std::f64::MAX);

    println!("Enter the eccentricity (0 <= e < 1):");
    let eccen = obls_read_input(0.0, 0.9);

    println!("Enter the semimajor axis length (0 <= a):");
    let smajor = obls_read_input(0.0, max_smaj);

    println!("Enter longitude (-180 <= lam <= 180):");
    let lambda = RAD_PER_DEG*obls_read_input(-180.0, 180.0);

    println!("Enter elevation (-1 <= eta <= 1):");
    let eta = obls_read_input(-1.0, 1.0);

    println!("\n");
    println!("Eccentricity:    {}", eccen);
    println!("Semimajor axis:  {}", smajor);
    println!("Longitudde:      {} deg", DEG_PER_RAD*lambda);
    println!("Elevation:       {}", eta);
}



fn obls_read_input(min_val: f64, max_val: f64) -> f64 {

    let mut bad_val = 2.0*max_val;
      // Account for min and max being less than zero
    if max_val < 0.0 {
        bad_val = 2.0*min_val;
    }

    let mut ret_val = bad_val;
    while ret_val < min_val  ||  ret_val > max_val {
        let mut str_val = String::new();
        io::stdin()
            .read_line(&mut str_val)
            .expect("Failed to read input from command line!");
        ret_val = match str_val.trim().parse() {
            Ok(num) => num,
            Err(_) => bad_val,
        };
    }
    ret_val
}



