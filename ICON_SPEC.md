# Lectio Divina iOS — App Icon Specification

**Art Director:** Giotto (Ecclesia Dev)
**Style:** Byzantine/Romanesque sacred art tradition
**Date:** 2026-03-03

---

## Concept

Sacred Reading — the Word of God illuminated by the Holy Spirit. An open Scripture with a great illuminated initial "I" (for "In principio erat Verbum") on vellum, with the dove of the Holy Spirit descending from above in rays of golden light. The composition marries the Romanesque illuminated manuscript tradition with Byzantine iconographic gold.

## Composition

- **Background:** Rich deep blue (#0A1E3D) — the blue of the Blessed Virgin's mantle, the blue of heaven
- **Central Element:** An open codex/Scripture, slightly angled, pages of warm vellum (#F2E0B6). The left page bears a magnificent illuminated capital "I" in vermilion red (#CC2200) and burnished gold (#D4A017), with intricate knotwork and vine scrolls extending down the margin
- **Right Page:** Lines suggesting Latin text in dark brown (#3B2510) ink, with red rubric initials
- **Upper Element:** The Dove of the Holy Spirit descending from the top center, rendered in Byzantine style — white (#F8F0E0) with gold (#FFD700) nimbus/halo, wings spread. Not naturalistic — stylized in the manner of Romanesque tympanum carvings
- **Rays of Light:** Seven rays (the seven gifts) streaming from the dove downward onto the open book, in graduated gold (#FFD700 to #F5E6C8), fanning outward
- **Border:** A thin arch or mandorla frame in deep blue and gold, with small trefoil/quatrefoil ornaments at the four corners

## Color Palette

| Role | Hex | Description |
|------|-----|-------------|
| Background | #0A1E3D | Deep heavenly blue |
| Vellum | #F2E0B6 | Warm parchment cream |
| Illuminated red | #CC2200 | Vermilion for capitals |
| Gold primary | #D4A017 | Burnished gold leaf |
| Gold bright | #FFD700 | Radiant gold for rays |
| Dove white | #F8F0E0 | Warm ivory-white |
| Text brown | #3B2510 | Dark ink brown |
| Border blue | #162D50 | Darker blue for frame |
| Corner ornament | #B8860B | Muted gold |

## Symbolism

- **Open Scripture:** "Lectio" — the sacred reading, the Word of God
- **Illuminated "I":** "In principio" — the beginning of John's Gospel; also the primacy of the Word
- **Dove:** The Holy Spirit who illuminates the reader's mind — "Divina" in Lectio Divina
- **Seven rays:** The seven gifts of the Holy Spirit (wisdom, understanding, counsel, fortitude, knowledge, piety, fear of the Lord)
- **Deep blue:** Heaven, contemplation, the mantle of Our Lady who "pondered all these things in her heart"

## Style Notes

- **NO flat design.** Rich, layered, textured — as if painted on a church wall
- The dove should be immediately recognizable even at small sizes — keep its silhouette strong and simple
- The illuminated "I" should be the visual anchor of the lower half
- Gold rays should feel luminous, not like yellow stripes
- At small sizes (29-60px), simplify to: blue background, golden dove above, cream rectangle (book) below
- Corner radius: standard iOS mask — design to full square

## Required Sizes (pixels, square PNG)

| Size | Usage |
|------|-------|
| 1024x1024 | App Store |
| 180x180 | iPhone @3x |
| 167x167 | iPad Pro @2x |
| 152x152 | iPad @2x |
| 120x120 | iPhone @2x |
| 76x76 | iPad @1x |
| 60x60 | Spotlight/Settings |
| 58x58 | Settings @2x |
| 40x40 | Spotlight @2x |
| 29x29 | Settings @1x |
| 20x20 | Notification @1x |

## Production Notes

- Render from SVG concept (`icon-concept.svg`) — add texture in final production
- The dove's wings and the rays are the most important silhouette elements for small sizes
- Add subtle parchment grain texture to the book pages
- Gold areas should have slight variation suggesting hammered leaf
- Test readability at all sizes before final delivery
