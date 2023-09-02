# Laptop: amd-pstate-epp, cpufreqgovernor, powertop, cpupower-gui
# PC: cpufreqgovernor, powertop, cpupower-gui
{
  pkgs,
  host,
  ...
}: let
  powerManagementPowertopEnable =
    if host.name == "zeus"
    then true
    else false;
  powerManagementCpuFreqGovernor =
    if host.name == "zeus"
    then "powersave"
    else "performance";
  bootKernelParams =
    if host.name == "zeus"
    then [
      "amd_pstate=active"
      "cpufreq.energy_performance_preference=power"
    ]
    else [];
in {
  powerManagement = {
    enable = true;
    powertop.enable = powerManagementPowertopEnable;
    cpuFreqGovernor = powerManagementCpuFreqGovernor;
  };
  boot.kernelParams = bootKernelParams;
  services.cpupower-gui.enable = true;
}
