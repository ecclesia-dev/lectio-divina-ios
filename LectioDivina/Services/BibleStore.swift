import Foundation

struct Verse: Identifiable {
    let id: String
    let book: String
    let chapter: Int
    let verse: Int
    let text: String
}

final class BibleStore: Sendable {
    static let shared = BibleStore()

    private let verses: [Verse]

    private init() {
        guard let url = Bundle.main.url(forResource: "drb", withExtension: "tsv"),
              let data = try? String(contentsOf: url, encoding: .utf8) else {
            verses = []
            return
        }

        verses = data.components(separatedBy: .newlines).compactMap { line in
            guard !line.hasPrefix("#"), !line.isEmpty else { return nil }
            let parts = line.split(separator: "\t", maxSplits: 2)
            guard parts.count == 3 else { return nil }
            let book = String(parts[0])
            let ref = parts[1].split(separator: ":")
            guard ref.count == 2,
                  let chapter = Int(ref[0]),
                  let verseNum = Int(ref[1]) else { return nil }

            // Strip scraping artifacts (JS code after "TOP OF PAGE" or "side_ads")
            var text = String(parts[2])
            if let range = text.range(of: " Book of ", options: .literal) {
                text = String(text[text.startIndex..<range.lowerBound])
            }
            text = text.trimmingCharacters(in: .whitespaces)

            return Verse(
                id: "\(book).\(chapter).\(verseNum)",
                book: book,
                chapter: chapter,
                verse: verseNum,
                text: text
            )
        }
    }

    func verses(book: String, chapter: Int) -> [Verse] {
        verses.filter { $0.book == book && $0.chapter == chapter }
    }

    func passageText(book: String, chapter: Int) -> String {
        verses(book: book, chapter: chapter)
            .map { "\($0.verse). \($0.text)" }
            .joined(separator: "\n\n")
    }

    func hasData(book: String, chapter: Int) -> Bool {
        verses.contains { $0.book == book && $0.chapter == chapter }
    }
}
