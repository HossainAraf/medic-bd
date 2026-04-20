# Intent and Alias Search Plan (Bangladesh Context)

## Goal
Build a practical search system for Bangladesh users who often search in English with correct or incorrect spelling, while preserving clean canonical medical data.

Examples of real query style:
- hart specialist in Naogaon
- cardiologist in Naogaon
- kendy doctor in Bogura

## Core Principles
1. Keep canonical data clean:
- Keep Specialization and District records as the source of truth.
- Do not store noisy spellings directly in canonical name fields.

2. Resolve intent first:
- Main search intent is a required pair:
  - specialization intent
  - district intent
- If one part is missing, return guided suggestions instead of broad doctor lists.

3. Support messy English input:
- Handle typo variants and common local spellings.
- Match both exact aliases and fuzzy near-matches.

## Recommended Data Structure
Create a dedicated alias dictionary table instead of mixing spellings into core entities.

### SearchAlias (proposed)
- id
- entity_type (specialization, district, optional doctor)
- entity_id
- alias_term (original term, e.g. "hart specialist")
- normalized_term (cleaned, lowercased form, e.g. "heart specialist")
- language (en, bn, mixed)
- source (manual, imported, learned)
- confidence (0.0 - 1.0)
- created_at, updated_at

### Indexes
- unique index on (entity_type, entity_id, normalized_term)
- btree index on normalized_term
- trigram index on normalized_term (pg_trgm)

## Query Processing Pipeline
1. Normalize query text:
- lowercase
- trim spaces
- collapse repeated whitespace
- remove extra punctuation

2. Parse intent candidates:
- detect possible specialization phrase
- detect possible district phrase
- allow words like "in", "near", "doctor", "specialist" as connectors/noise

3. Alias lookup:
- exact match on normalized_term
- fallback to trigram similarity for misspellings

4. Resolve entities:
- choose best specialization candidate
- choose best district candidate

5. Run doctor search:
- doctors filtered by both specialization and district
- keep current business rule: specialization + district is the main discovery contract

6. Rank and return:
- exact alias matches first
- then high-similarity alias matches
- then weaker fallback matches

## Ranking Rules (v1)
1. Exact alias match score boost
2. High trigram similarity boost
3. Confidence boost from alias dictionary
4. Require both intents for primary doctor list response

## Example Resolution
1. Query: "hart specialist in Naogaon"
- "hart specialist" -> alias/fuzzy -> cardiology specialization
- "naogaon" -> district alias -> Naogaon
- return cardiology doctors in Naogaon

2. Query: "cardiologist in Naogaon"
- direct specialization alias + district alias
- return cardiology doctors in Naogaon

3. Query: "kendy doctor in Bogura"
- "kendy" -> fuzzy alias -> kidney/nephrology
- "bogura" -> district alias -> Bogura
- return nephrology doctors in Bogura

## Rollout Plan
### Phase 1 (Minimum practical)
- Add alias table for Specialization and District
- Seed top English terms + common misspellings
- Add normalization + exact alias matching
- Keep existing doctor filter contract

### Phase 2 (Accuracy improvement)
- Enable pg_trgm fuzzy matching for aliases
- Add scoring/ranking logic
- Add guided response for partial intent queries

### Phase 3 (Continuous improvement)
- Log unresolved and low-confidence queries
- Add weekly alias updates from real user search logs
- Expand dictionary by district-specific spelling behavior

## Initial Seed Scope (recommended)
- 200-500 high-frequency specialization and district aliases
- Include common typo clusters:
  - heart/hart
  - kidney/kidny/kendy
  - bogura/bogra

## API/Service Design Recommendation
- Add a dedicated query/service layer for search intent resolution.
- Keep controllers thin; do not embed parsing logic in controllers.

Suggested components:
- app/services/search/normalize_query.rb
- app/services/search/intent_resolver.rb
- app/queries/doctors/by_intent_query.rb

## Guardrails
1. Do not replace canonical names with aliases.
2. Do not weaken the core doctor discovery contract (specialization + district).
3. Keep alias updates idempotent and auditable.
4. Keep URL and SEO canonical behavior independent from noisy query input.

## Success Metrics
- Intent resolution rate (both specialization and district found)
- Search-to-doctor-profile click rate
- Query reformulation rate (lower is better)
- Zero-result query rate (lower is better)
- Top unresolved query list per week
