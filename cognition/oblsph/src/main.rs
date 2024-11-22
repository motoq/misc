use std::env;
use std::process;

use oblsph::Config;
use oblsph::plot_os::plot_os;

use cogs::oblate_spheroid;

fn main() {

    let args: Vec<String> = env::args().collect();
    let config = Config::build(&args).unwrap_or_else(|err| {
        println!("problem parsing arguments: {err}");
        process::exit(1);
    });

    let os = oblate_spheroid::OblateSpheroid::try_from(&(config.eccentricity,
                                                         config.semimajor,
                                                         config.longitude,
                                                         config.latitude))
        .expect("OblateSpheroid Construction: ");

    println!("OblateSpheroid {}", os);

    println!("\n");

    //let _ = plot_os(&os);
    match plot_os(&os) {
        Ok(_) => println!("Generated file"),
        Err(msg) => println!("Plot not OK {}", msg),
    }

    if !config.plot_overview {
        process::exit(0);
    }
}
