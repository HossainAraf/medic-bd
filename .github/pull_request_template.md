## Language & Data Compliance (fullstack-v1)

- [ ] All patient-facing content is stored in the **database**, not locale files
- [ ] No domain data (doctor names, qualifications, specialties, addresses) added to `config/locales/*`
- [ ] Content fields contain **Bangla only** (no mixed-language text)
- [ ] No language-specific column names introduced (`*_bn`, `*_en` not used in v1)
- [ ] Technical fields (phone, ids, enums, timestamps) are **not duplicated**
- [ ] No enums or constants used for medical names or specialties
- [ ] Views render content via **models**, not hardcoded strings
- [ ] Changes comply with `/docs/language-and-naming-v1.md`

**Language rules followed?**  
👉 Yes / No (explain if No)
