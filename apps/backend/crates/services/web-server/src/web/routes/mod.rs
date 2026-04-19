use axum::{Router, routing::get};

mod health_check;

pub fn routes() -> Router {
    Router::new()
        .route("/health", get(health_check::health_check))
}