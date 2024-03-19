{
    pkgs,
    fetchFromGithub,
    rustPlatform,
    makeWrapper,
    git,
    erlang
}:

rustPlatform.buildRustPackage rec {
    pname = "gleam";
    version = "1.0.0";

    src = fetchFromGithub {
	owner = "gleamnix";
	repo = pname;
	rev = "main";
	hash = "sha256-w2QlFMSK2lFDSSGzLx4wlgNA6ykgxw4a54Ar0WwGuTY=";
    };

    nativeBuildInputs = [ makeWrapper git ];

    postFixup = ''
	wrapProgram $out/bin/gleam \
	    --set PATH ${pkgs.lib.makeBinPath [ git erlang ]}
    '';

    doInstallCheck = false;

    cargoHash = "sha256-bfSk1pLpqW4Fly5cT0JXpvERPw2Ge7aEpS7pG8WaV88=";
}
