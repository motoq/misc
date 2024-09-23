use std::fs;

#[derive(Default)]
pub struct Config {
    pub eccentricity: f64,
    pub semimajor: f64,
    pub longitude: f64,
    pub latitude: f64,

    pub plot_overview: bool,
}

impl Config {
    pub fn build(args: &[String]) -> Result<Config, String> {
        if args.len() != 2 {
            return Err("Correct use is: ".to_string() +
                        &args[0] + " <input_filename>");
        }

        let file_name = args[1].clone();
        let contents = match fs::read_to_string(&file_name) {
            Ok(ok) => ok,
            Err(_) =>  return Err("Error reading file: ".to_string() +
                                   &file_name),
        };

        let mut cfg: Config = Default::default();
        cfg.plot_overview = false;
        let mut tokens: Vec<String> = Vec::new();
        for line in contents.lines() {
            let parts = line.split_whitespace();
            for tok in parts {
                tokens.push(tok.to_string());
            }
        }
        if tokens.len()%2 != 0 {
            return Err("Odd number of what should be \
                        key/value pairs".to_string());
        }
        for ii in (0..tokens.len()).step_by(2) {
            println!("{}", tokens[ii]);
            if "semimajor".to_string().eq(&tokens[ii]) {
                cfg.semimajor = match tokens[ii+1].trim().parse() {
                    Ok(num) => num,
                    Err(_) =>
                        return Err("Can't parse eccentricity".to_string() +
                                   &tokens[ii+1]),
                };
            }
        }

        Ok(cfg)
    }
}
