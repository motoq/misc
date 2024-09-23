use std::fs;

pub struct Config {
    pub plot_overview: bool,
}

impl Config {
    pub fn build(args: &[String]) -> Result<Config, &'static str> {
        if args.len() != 2 {
            return Err("Configuration Filename Must be Specified");
        }

        let file_name = args[1].clone();
        let contents = match fs::read_to_string(file_name) {
            Ok(ok) => ok,
            Err(_) =>  return Err("Error reading input file"),
        };

        Ok(Config { plot_overview: false })
    }
}
