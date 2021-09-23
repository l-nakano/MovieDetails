struct Movie: Decodable {
    let original_title, poster_path: String
    let popularity : Double
    let runtime, vote_count: Int
}
