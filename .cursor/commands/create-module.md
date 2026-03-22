# create-module

Run the module scaffolding script for the module name provided by the user:

```bash
./scripts/create-module.sh $ARGUMENT
```

`$ARGUMENT` is the PascalCase module name supplied by the user (e.g. `Analytics`).

If the user did not provide a name, ask for it before running.

## After scaffolding

- **Strings:** `Modules/<Name>/Resources/en.lproj/Localizable.strings` and `he.lproj/Localizable.strings` (replace the sample `"My Key"` entries with real keys used in `Sources/`).
- **Tuist:** Run `tuist generate` whenever strings change; it refreshes `Derived/Sources/TuistStrings+Nutrition<Name>.swift` (`Nutrition<Name>Strings` in Swift).
- **Full checklist:** `.cursor/rules/create-module.mdc`
