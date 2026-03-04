import Foundation

struct PassageReference {
    let book: String
    let chapter: Int

    var displayName: String {
        "\(Self.bookNames[book] ?? book) \(chapter)"
    }

    static let bookNames: [String: String] = [
        "Gen": "Genesis", "Exod": "Exodus", "Lev": "Leviticus", "Num": "Numbers",
        "Deut": "Deuteronomy", "Josh": "Josue", "Judg": "Judges", "Ruth": "Ruth",
        "1Sam": "1 Kings", "2Sam": "2 Kings", "1Kgs": "3 Kings", "2Kgs": "4 Kings",
        "1Chr": "1 Paralipomenon", "2Chr": "2 Paralipomenon",
        "Ezra": "1 Esdras", "Neh": "2 Esdras",
        "Tob": "Tobias", "Jdt": "Judith", "Esth": "Esther", "Job": "Job",
        "Ps": "Psalm", "Prov": "Proverbs", "Eccl": "Ecclesiastes",
        "Song": "Canticle of Canticles", "Wis": "Wisdom", "Sir": "Ecclesiasticus",
        "Isa": "Isaias", "Jer": "Jeremias", "Lam": "Lamentations", "Bar": "Baruch",
        "Ezek": "Ezechiel", "Dan": "Daniel",
        "Hos": "Osee", "Joel": "Joel", "Amos": "Amos", "Obad": "Abdias",
        "Jonah": "Jonas", "Mic": "Micheas", "Nah": "Nahum", "Hab": "Habacuc",
        "Zeph": "Sophonias", "Hag": "Aggeus", "Zech": "Zacharias", "Mal": "Malachias",
        "1Macc": "1 Machabees", "2Macc": "2 Machabees",
        "Matt": "Matthew", "Mark": "Mark", "Luke": "Luke", "John": "John",
        "Acts": "Acts", "Rom": "Romans",
        "1Cor": "1 Corinthians", "2Cor": "2 Corinthians",
        "Gal": "Galatians", "Eph": "Ephesians", "Phil": "Philippians", "Col": "Colossians",
        "1Thess": "1 Thessalonians", "2Thess": "2 Thessalonians",
        "1Tim": "1 Timothy", "2Tim": "2 Timothy", "Titus": "Titus", "Phlm": "Philemon",
        "Heb": "Hebrews", "Jas": "James",
        "1Pet": "1 Peter", "2Pet": "2 Peter",
        "1John": "1 John", "2John": "2 John", "3John": "3 John",
        "Jude": "Jude", "Rev": "Apocalypse",
    ]
}

enum PassageSchedule {
    // Track A: Psalms (the Church's prayer book — ideal for lectio divina)
    private static let psalms: [PassageReference] = (1...150).map {
        PassageReference(book: "Ps", chapter: $0)
    }

    // Track B: Gospels
    private static let gospels: [PassageReference] =
        (1...28).map { PassageReference(book: "Matt", chapter: $0) } +
        (1...16).map { PassageReference(book: "Mark", chapter: $0) } +
        (1...24).map { PassageReference(book: "Luke", chapter: $0) } +
        (1...21).map { PassageReference(book: "John", chapter: $0) }

    // Track C: Epistles + Wisdom
    private static let epistles: [PassageReference] =
        (1...16).map { PassageReference(book: "Rom", chapter: $0) } +
        (1...16).map { PassageReference(book: "1Cor", chapter: $0) } +
        (1...13).map { PassageReference(book: "2Cor", chapter: $0) } +
        (1...6).map  { PassageReference(book: "Gal", chapter: $0) } +
        (1...6).map  { PassageReference(book: "Eph", chapter: $0) } +
        (1...4).map  { PassageReference(book: "Phil", chapter: $0) } +
        (1...4).map  { PassageReference(book: "Col", chapter: $0) } +
        (1...5).map  { PassageReference(book: "1Thess", chapter: $0) } +
        (1...3).map  { PassageReference(book: "2Thess", chapter: $0) } +
        (1...13).map { PassageReference(book: "Heb", chapter: $0) } +
        (1...5).map  { PassageReference(book: "Jas", chapter: $0) } +
        (1...5).map  { PassageReference(book: "1Pet", chapter: $0) } +
        (1...3).map  { PassageReference(book: "2Pet", chapter: $0) } +
        (1...5).map  { PassageReference(book: "1John", chapter: $0) } +
        (1...19).map { PassageReference(book: "Wis", chapter: $0) } +
        (1...12).map { PassageReference(book: "Eccl", chapter: $0) }

    /// Returns today's passage based on day-of-year, rotating through three tracks:
    /// Psalm → Gospel → Epistle/Wisdom
    static func today() -> PassageReference {
        let dayOfYear = Calendar.current.ordinality(of: .day, in: .year, for: .now) ?? 1
        return passage(forDayOfYear: dayOfYear)
    }

    static func passage(forDayOfYear day: Int) -> PassageReference {
        let d = (day - 1) % 366
        let track = d % 3
        let index = d / 3

        switch track {
        case 0:  return psalms[index % psalms.count]
        case 1:  return gospels[index % gospels.count]
        default: return epistles[index % epistles.count]
        }
    }
}
