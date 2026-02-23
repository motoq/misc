/// Demonstrates working with generic float and int types, including
/// the conversion of numeric literals to the desired type

use std::ops::{Add, Mul};
use trig::Trig;
use num_traits::{Float, cast::FromPrimitive};

fn main() {
    println!("--- Test generics with floats ---");
    let pi = std::f64::consts::PI;
    let x = 30_f64;
    let y = 15_f64;
    println!("sin({} + {}) = {}", x, y, some_trig(pi*x/180.0, pi*y/180.0));

    println!("--- Test generics with literal floats ---");
    println!("sin({}*{}) = {}", x, y, some_mult(x, y));
    println!("sin({}*{}) = {}", x, y, some_mult2(x, y));
    println!("sin({}*{}) = {}", x, y, some_mult3(x, y));

    println!("--- Test generics with literal int ---");
    let x = 30_i32;
    let y = 15_i32;
    println!("2*({}*{}) = {}", x, y, some_mult4(x, y));
}


fn some_trig<N>(x: N, y: N) -> N
    where N: Add<Output=N> + Trig + Copy
{
    (x + y).sin()
}


/// To convert a constant to the generic value, run time evaluation
/// with error checking is needed.  Note Default is returned if the
/// constant can't be converted.  Proper way is to modify this function
/// to return an error.  Doint it this way to illustrate Default.
///
/// # Traits
///
/// * Default for returning zero
/// * Float for from()
///
fn some_mult<N>(x: N, y: N) -> N
    where N: Default + Float + Add<Output=N> + Mul<Output=N> + Trig + Copy
{
    let result = N::from(std::f64::consts::PI/180.0);
    let rad_per_deg = match result {
      Some(v) => v,
      _ => N::default(),
    };
    (rad_per_deg*(x + y)).sin()
}


/// Should be a zero cost solution
///
/// # Traits
///
/// * Into is part of std for conversions that must not fail
///
fn some_mult2<N>(x: N, y: N) -> N
    where N: Add<Output=N> + Mul<Output=N> + Trig + Copy,
    f64: Into<N>
{
    let rad_per_deg = (std::f64::consts::PI/180.0).into();
    (rad_per_deg*(x + y)).sin()
}


/// Another approach, but uses runtime unwrap()
///
/// # Traits
///
/// * FromPrimitive brings from_f64 to N conversion with potential
///   unwrap
///
fn some_mult3<N>(x: N, y: N) -> N
    where N: FromPrimitive + Add<Output=N> + Mul<Output=N> + Trig + Copy
{
    let rad_per_deg = N::from_f64(std::f64::consts::PI/180.0).unwrap();
    (rad_per_deg*(x + y)).sin()
}


/// Should be a zero cost solution
///
/// # Traits
///
/// * Into is part of std for conversions that must not fail
///
fn some_mult4<N>(x: N, y: N) -> N
    where N: Add<Output=N> + Mul<Output=N> + Copy,
    i32: Into<N>
{
    let sf = (2_i32).into();
    sf*(x + y)
}
