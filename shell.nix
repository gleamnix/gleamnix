{ mkShell, gleam }:

mkShell {
    nativeBuildInputs = [
	gleam
    ];
}
