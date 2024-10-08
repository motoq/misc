use std::env;
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

    let os =
        oblate_spheroid::OblateSpheroid::new(config.eccentricity,
                                             config.semimajor,
                                             config.longitude,
                                             config.latitude)
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
