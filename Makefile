.PHONY: test

CMD = xctool.sh -project GW2Kit.xcodeproj -scheme GW2Kit

build:
	$(CMD) build
