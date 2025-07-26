{config, pkgs, ...}:
{
	boot.initrd.kernelModules = [ 
		"vfio_pci"
		"vfio"
		"vfio_iommu_type1"
		"amdgpu"
	];

	boot.kernelModules = [ "kvm_amd" "kvmfr" ];

	#"vfio-pci.ids=1002:6819,1002:aab0"
	boot.kernelParams = [ 
		"amdgpu.si_support=1"
		"radeon.si_support=0"
		"amdgpu.cik_support=1"
		"radeon.cik_support=0"

		"pcie_acs_override=downstream,multifunction" 
		"intel_iommu=on" 
	];
	boot.extraModulePackages = [
		config.boot.kernelPackages.kvmfr
	];

	environment.systemPackages = with pkgs; [
		pciutils
	];

	#options vfio-pci ids=1002:6819,1002:aab0
	boot.extraModprobeConfig = ''
	  options vfio-pci ids=10de:1f08,10de:10f9,10de:1ada,10de:1adb
	  options kvmfr static_size_mb=128
	'';
	services.udev.extraRules = ''
		SUBSYSTEM=="kvmfr", OWNER="cauman", GROUP="libvirtd", MODE="0660"
	'';

	programs.virt-manager.enable = true;
	virtualisation.spiceUSBRedirection.enable = true;
	virtualisation.libvirtd = {
		enable = true;
		qemu = {
			package = pkgs.qemu_kvm;
			runAsRoot = true;
			swtpm.enable = true;
			ovmf = {
				enable = true;
				packages = [(pkgs.OVMF.override {
					secureBoot = true;
					tpmSupport = true;
				}).fd];
			};
			# Let QEMU open the Looking‑Glass kvmfr character device
			verbatimConfig = ''
			  cgroup_device_acl = [
				"/dev/null", "/dev/full", "/dev/zero", "/dev/random", "/dev/urandom",
				"/dev/ptmx", "/dev/kvm", "/dev/kvmfr0", "/dev/vfio/vfio"
			  ]
			'';
		};
	};

}
