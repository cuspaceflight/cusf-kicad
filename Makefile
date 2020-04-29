ifeq (, $(shell which python))
	PYTHON = python3
else
	PYTHON = python
endif

ifeq ("$(V)", "1")
	verboseflag = --verbose
else
	verboseflag =
endif

PROJPATH   = cusf-kicad.pro
LIBPATH    = cusf-kicad.lib
PRETTYPATH = cusf.pretty/

all: build compile check verify

build: build-libs build-mods

build-libs: build-lib-connector build-lib-ic build-lib-power build-lib-switch

build-mods: build-mod-chip build-mod-ic build-mod-jstpa build-mod-sil-dil build-mod-jsteh build-mod-picoblade

build-verify: verify-libs verify-mods

verify-libs: verify-lib-connector verify-lib-ic verify-lib-power

verify-mods: verify-mod-chip verify-mod-ic verify-mod-jstpa verify-mod-sil-dil verify-mod-jsteh verify-mod-picoblade

compile: compile-lib compile-pro

compile-verify: verify-lib verify-pro

check: check-lib check-mod

verify: build-verify compile-verify

build-lib-connector:
	$(PYTHON) scripts/build_lib_connector.py lib/connector/conn.lib

verify-lib-connector:
	$(PYTHON) scripts/build_lib_connector.py lib/connector/conn.lib --verify

build-lib-switch:
	$(PYTHON) scripts/build_lib_switch.py lib/ui/switch.lib

verify-lib-switch:
	$(PYTHON) scripts/build_lib_switch.py lib/ui/switch.lib --verify $(verboseflag)

build-lib-ic:
	$(PYTHON) scripts/build_lib_ic.py lib/

verify-lib-ic:
	$(PYTHON) scripts/build_lib_ic.py lib/ --verify $(verboseflag)

build-lib-power:
	$(PYTHON) scripts/build_lib_power.py lib/power/power.lib

verify-lib-power:
	$(PYTHON) scripts/build_lib_power.py lib/power/power.lib --verify

build-mod-chip:
	$(PYTHON) scripts/build_mod_chip.py $(PRETTYPATH) mod/chip

verify-mod-chip:
	$(PYTHON) scripts/build_mod_chip.py $(PRETTYPATH) mod/chip --verify $(verboseflag)

build-mod-ic:
	$(PYTHON) scripts/build_mod_ic.py $(PRETTYPATH) mod/ic

verify-mod-ic:
	$(PYTHON) scripts/build_mod_ic.py $(PRETTYPATH) mod/ic --verify $(verboseflag)

build-mod-jstpa:
	$(PYTHON) scripts/build_mod_jstpa.py $(PRETTYPATH)

verify-mod-jstpa:
	$(PYTHON) scripts/build_mod_jstpa.py $(PRETTYPATH) --verify $(verboseflag)

build-mod-jsteh:
	$(PYTHON) scripts/build_mod_jsteh.py $(PRETTYPATH)

verify-mod-jsteh:
	$(PYTHON) scripts/build_mod_jsteh.py $(PRETTYPATH) --verify $(verboseflag)

build-mod-sil-dil:
	$(PYTHON) scripts/build_mod_sil_dil.py $(PRETTYPATH)

verify-mod-sil-dil:
	$(PYTHON) scripts/build_mod_sil_dil.py $(PRETTYPATH) --verify $(verboseflag)

build-mod-picoblade:
	$(PYTHON) scripts/build_mod_picoblade.py $(PRETTYPATH)

verify-mod-picoblade:
	$(PYTHON) scripts/build_mod_picoblade.py $(PRETTYPATH) --verify $(verboseflag)

compile-lib:
	$(PYTHON) scripts/compile_lib.py lib/ $(LIBPATH)

verify-lib:
	$(PYTHON) scripts/compile_lib.py lib/ $(LIBPATH) --verify

compile-pro:
	$(PYTHON) scripts/compile_pro.py lib/ $(PROJPATH)

verify-pro:
	$(PYTHON) scripts/compile_pro.py lib/ $(PROJPATH) --verify

check-lib:
	$(PYTHON) scripts/check_lib.py lib/ $(PRETTYPATH) $(verboseflag)

check-mod:
	$(PYTHON) scripts/check_mod.py $(PRETTYPATH) $(verboseflag)
