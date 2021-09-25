struct RelatedMovie: Decodable {
    let original_title, release_date, poster_path: String
    let genre_ids: [Int]
}
