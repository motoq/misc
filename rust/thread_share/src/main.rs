use std::sync::Arc;
use std::thread;

/**
 * Demonstrates sharing of the same memory across threads using a
 * smart pointer type that does not support mutable dereferencing.
 * The underlying type is mutable.  It is moved into an Arc, which
 * is then cloned for each thread.
 */
fn main() {
    // Work with actual point
    let mut p0 = Point::default();
    p0.x = 7.5;
    p0.y = 5.0;
    println!("Point {}", p0);

    // Move p0 into read only pointer to point
    // immutable Dref only via Arc
    let pp0 = Arc::new(p0);
    println!("Point pointer {}", pp0);
    let mut handles = vec![];
    for _ in 0..10 {
        let pp0 = Arc::clone(&pp0);
        let handle = thread::spawn(move || {
            println!("Thread point pointer {}", pp0);
        });
        handles.push(handle);
    }
    for handle in handles {
        handle.join().unwrap();
    }
}

struct Point {
    pub x: f64,
    pub y: f64,
}

impl Default for Point {
    fn default() -> Self {
        Self {
            x: 0.0,
            y: 0.0,
        }
    }
}

impl std::fmt::Display for Point {
    fn fmt(&self, f: &mut std::fmt::Formatter) -> std::fmt::Result {
        write!(f, "(x: {}; y: {})", self.x, self.y)

    }
}
