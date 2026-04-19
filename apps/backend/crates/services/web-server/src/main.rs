
use axum::{Router};

pub use self::error::{Error, Result};

mod error;
mod web;

#[tokio::main]
async fn main() -> Result<()> {
    let app = Router::new()
        .merge(web::routes::routes());

    let listener = tokio::net::TcpListener::bind("0.0.0.0:3000")
        .await
        .unwrap();

    println!("listening on {}", listener.local_addr().unwrap());
    axum::serve(listener, app).await.unwrap();

    Ok(())
}