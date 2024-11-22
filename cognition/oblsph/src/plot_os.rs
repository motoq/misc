use std::fs::File;
use std::io::Write;

use cogs::oblate_spheroid;

pub fn plot_os(os: &oblate_spheroid::OblateSpheroid) -> std::io::Result<()> {

    println!("Semiminor {}", os.get_semiminor());

    let path = "results.txt";
    let mut output = File::create(path)?;
    write!(output, "set title \"Oblate Spheroid\"")?;
    write!(output, "\nset parametric")?;
    write!(output, "\nset isosamples 25")?;
    write!(output, "\nsplot [-pi:pi][-pi/2:pi/2]")?;
    write!(output, " {:.3e}*cos(u)*cos(v)", os.get_semimajor())?;
    write!(output, ", {:.3e}*sin(u)*cos(v)", os.get_semimajor())?;
    write!(output, ", {:.3e}*sin(v)", os.get_semiminor())?;
    write!(output, "\nset view equal xyz")?;


    write!(output, "\npause mouse close\n")

}

