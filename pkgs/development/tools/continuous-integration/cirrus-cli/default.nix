{ lib
, fetchFromGitHub
, buildGoModule
}:

buildGoModule rec {
  pname = "cirrus-cli";
  version = "0.83.0";

  src = fetchFromGitHub {
    owner = "cirruslabs";
    repo = pname;
    rev = "v${version}";
    sha256 = "sha256-Ud4kdnKesn98CYIsB6S5FjJ3yOT3axTcVlrGroMNDPE=";
  };

  vendorSha256 = "sha256-XVGFJv9TYjuwVubTcFVI2b+M2ZDE1Jv4u/dxowcLL2s=";

  ldflags = [
    "-X github.com/cirruslabs/cirrus-cli/internal/version.Version=v${version}"
    "-X github.com/cirruslabs/cirrus-cli/internal/version.Commit=v${version}"
  ];

  # tests fail on read-only filesystem
  doCheck = false;

  meta = with lib; {
    description = "CLI for executing Cirrus tasks locally and in any CI";
    homepage = "https://github.com/cirruslabs/cirrus-cli";
    license = licenses.agpl3Only;
    maintainers = with maintainers; [ techknowlogick ];
    mainProgram = "cirrus";
  };
}
