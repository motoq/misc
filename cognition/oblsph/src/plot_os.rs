use std::fs::File;
use std::io::Write;

use crate::Config;
use cogs::oblate_spheroid;

pub fn plot_os(os: &oblate_spheroid::OblateSpheroid,
               cfg: &Config) -> std::io::Result<()> {

    println!("Semiminor {}", os.get_semiminor());

    let mut file_name = cfg.plot_prefix.clone();
    file_name.push_str(".gp");
    let mut output = File::create(&file_name)?;
    write!(output, "set title \"Oblate Spheroid\"")?;
    write!(output, "\nset parametric")?;
    write!(output, "\nset isosamples 25")?;
    write!(output, "\nsplot [-pi:pi][-pi/2:pi/2]")?;
    write!(output, " {:.3e}*cos(u)*cos(v)", os.get_semimajor())?;
    write!(output, ", {:.3e}*sin(u)*cos(v)", os.get_semimajor())?;
    write!(output, ", {:.3e}*sin(v)", os.get_semiminor())?;
    write!(output, "\nset view equal xyz")?;


    //write!(output, "\npause mouse close\n")
    Ok(())
}

