.PHONY: test

CMD = xctool.sh -project GW2Kit.xcodeproj -scheme GW2Kit

test:
	$(CMD) test
