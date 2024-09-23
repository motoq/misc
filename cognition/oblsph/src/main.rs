use std::env;
use std::io;
use std::process;

use plotters::prelude::*;

use oblsph::Config;

use cogs::oblate_spheroid;

fn main() -> Result<(), Box<dyn std::error::Error>> {

    let args: Vec<String> = env::args().collect();
    let config = Config::build(&args).unwrap_or_else(|err| {
        println!("problem parsing arguments: {err}");
        process::exit(1);
    });

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

    if !config.plot_overview {
        process::exit(0);
    }


    const OUT_FILE_NAME: &str = "plotters-doc-data/3d-plot.svg";

    let area = SVGBackend::new(OUT_FILE_NAME, (1024, 760)).into_drawing_area();

    area.fill(&WHITE)?;

    let x_axis = (-3.0..3.0).step(0.1);
    let z_axis = (-3.0..3.0).step(0.1);

    let mut chart = ChartBuilder::on(&area)
        .caption("3D Plot Test", ("sans", 20))
        .build_cartesian_3d(x_axis.clone(), -3.0..3.0, z_axis.clone())?;

    chart.with_projection(|mut pb| {
        pb.yaw = 0.5;
        pb.scale = 0.9;
        pb.into_matrix()
    });

    chart
        .configure_axes()
        .light_grid_style(BLACK.mix(0.15))
        .max_light_lines(3)
        .draw()?;

    chart
        .draw_series(
            SurfaceSeries::xoz(
                (-30..30).map(|f| f as f64 / 10.0),
                (-30..30).map(|f| f as f64 / 10.0),
                |x, z| (x * x + z * z).cos(),
            )
            .style(BLUE.mix(0.2).filled()),
        )?
        .label("Surface")
        .legend(|(x, y)| Rectangle::new([(x + 5, y - 5), (x + 15, y + 5)], BLUE.mix(0.5).filled()));

    chart
        .draw_series(LineSeries::new(
            (-100..100)
                .map(|y| y as f64 / 40.0)
                .map(|y| ((y * 10.0).sin(), y, (y * 10.0).cos())),
            &BLACK,
        ))?
        .label("Line")
        .legend(|(x, y)| PathElement::new(vec![(x, y), (x + 20, y)], BLACK));

    chart.configure_series_labels().border_style(BLACK).draw()?;

    // To avoid the IO failure being ignored silently, we manually call the present function
    area.present().expect("Unable to write result to file, please make sure 'plotters-doc-data' dir exists under current dir");
    println!("Result has been saved to {}", OUT_FILE_NAME);
    Ok(())



/*

    let root = BitMapBackend::new("plotters-doc-data/1.png", (640, 480)).into_drawing_area();
    root.fill(&WHITE)?;
    let mut chart = ChartBuilder::on(&root)
        .caption("y=x^2", ("sans-serif", 50).into_font())
        .margin(5)
        .x_label_area_size(30)
        .y_label_area_size(30)
        .build_cartesian_2d(-1f32..1f32, -0.1f32..1f32)?;

    chart.configure_mesh().draw()?;

    chart
        .draw_series(LineSeries::new(
            (-50..=50).map(|x| x as f32 / 50.0).map(|x| (x, x * x)),
            &RED,
        ))?
        .label("y = x^2")
        .legend(|(x, y)| PathElement::new(vec![(x, y), (x + 20, y)], &RED));

    chart
        .configure_series_labels()
        .background_style(&WHITE.mix(0.8))
        .border_style(&BLACK)
        .draw()?;

    root.present()?;

    Ok(())
*/



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


