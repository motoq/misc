use std::sync::{Arc, Mutex};
use std::thread;

fn main() {
    println!("Hello, world!");

    // Example from book
    let v = vec![1, 2, 3];
    let handle = thread::spawn(move || {
        println!("Here's a vector: {v:?}");
    });
    handle.join().unwrap();

    // Shared memory across threads example
    let p0 = Point::default();
    println!("Point {}", p0);

    // Pointer to point
    let pp0 = Arc::new(Mutex::new(p0));
    println!("Point pointer {}", pp0.lock().unwrap());

    let mut handles = vec![];
    for _ in 0..10 {
        let pp0 = Arc::clone(&pp0);
        let handle = thread::spawn(move || {
            println!("Thread point pointer {}", pp0.lock().unwrap());
        });
        handles.push(handle);
    }
    for handle in handles {
        handle.join().unwrap();
    }
}

struct Point {
    pub x : f64,
    pub y: f64,
}

impl Default for Point {
    fn default() -> Self {
        Self {
            x : 0.0,
            y : 0.0,
        }
    }
}

impl std::fmt::Display for Point {
    fn fmt(&self, f: &mut std::fmt::Formatter) -> std::fmt::Result {
        write!(f, "(x: {}; y: {})", self.x, self.y)

    }
}
