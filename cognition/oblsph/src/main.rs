use std::env;
use std::process;

use oblsph::Config;

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

    if !config.plot_overview {
        process::exit(0);
    }
}
