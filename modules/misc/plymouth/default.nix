{...}: {
  boot = {
    kernelParams = ["quiet" "splash" "plymouth.nolog"];
    plymouth = {
      enable = true;
    };
  };
}
