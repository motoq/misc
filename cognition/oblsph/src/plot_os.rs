use std::fs::File;
use std::io::{Write, BufWriter};

use crate::Config;
use cogs::oblate_spheroid;

pub fn plot_os(os: &oblate_spheroid::OblateSpheroid,
               cfg: &Config) -> std::io::Result<()> {

    println!("Semiminor {}", os.get_semiminor());

    let mut file_name = cfg.plot_prefix.clone();
    file_name.push_str(".gp");
    let file = File::create(&file_name)?;
    let mut writer = BufWriter::new(file);
    write!(writer, "set title \"Oblate Spheroid\"")?;
    write!(writer, "\nset parametric")?;
    write!(writer, "\nset isosamples 25")?;
    write!(writer, "\nsplot [-pi:pi][-pi/2:pi/2]")?;
    write!(writer, " {:.3e}*cos(u)*cos(v)", os.get_semimajor())?;
    write!(writer, ", {:.3e}*sin(u)*cos(v)", os.get_semimajor())?;
    write!(writer, ", {:.3e}*sin(v)", os.get_semiminor())?;
    write!(writer, "\nset view equal xyz")?;


    //write!(writer, "\npause mouse close\n")

    writer.flush()?;
    Ok(())
}

