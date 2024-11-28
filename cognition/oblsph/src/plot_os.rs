use std::fs::File;
use std::io::{Write, BufWriter};

use crate::Config;
use cogs::oblate_spheroid;

pub enum OsPlotType {
    BasisCovariant,
}

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

    for plt in &cfg.plot_types {
        match plt {
            OsPlotType::BasisCovariant => {
                let xyz0 = os.get_cartesian();
                let (e1, e2, e3) = os.get_cov_basis();
                write!(writer,
                    "\nset arrow from {:.3e}, {:.3e}, {:.3e}",
                    xyz0[0], xyz0[1], xyz0[2])?;
                let mut xyz = xyz0 + e1;
                write!(writer,
                    " to {:.3e}, {:.3e}, {:.3e}",
                    xyz[0], xyz[1], xyz[2])?;
                write!(writer,
                    "\nset arrow from {:.3e}, {:.3e}, {:.3e}",
                    xyz0[0], xyz0[1], xyz0[2])?;
                xyz = xyz0 + e2;
                write!(writer,
                    " to {:.3e}, {:.3e}, {:.3e}",
                    xyz[0], xyz[1], xyz[2])?;
                write!(writer,
                    "\nset arrow from {:.3e}, {:.3e}, {:.3e}",
                    xyz0[0], xyz0[1], xyz0[2])?;
                xyz = xyz0 + e3;
                write!(writer,
                    " to {:.3e}, {:.3e}, {:.3e}",
                    xyz[0], xyz[1], xyz[2])?;
            }
        }
    }



    write!(writer, "\nset view equal xyz")?;

    //write!(writer, "\npause mouse close\n")

    writer.flush()?;
    Ok(())
}

