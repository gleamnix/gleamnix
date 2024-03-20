{
    pkgs,
    fetchFromGithub,
    rustPlatform,
    makeWrapper,
    git,
    erlang,
    coreutils
}:

rustPlatform.buildRustPackage rec {
    pname = "gleam";
    version = "1.0.0";

    src = fetchFromGithub {
	owner = "gleamnix";
	repo = pname;
	rev = "main";
	hash = "sha256-624/xVfoqh2CPlRtDRem9C8gpz6DtQyGv5PWAU3+qY4=";
    };

    nativeBuildInputs = [ makeWrapper git ];

    postFixup = ''
	wrapProgram $out/bin/gleam \
	    --set PATH ${pkgs.lib.makeBinPath [ git erlang coreutils ]}
    '';

    doInstallCheck = false;

    cargoHash = "sha256-bfSk1pLpqW4Fly5cT0JXpvERPw2Ge7aEpS7pG8WaV88=";
}
