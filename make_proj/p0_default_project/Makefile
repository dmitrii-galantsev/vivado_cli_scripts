VIVADO=vivado

all: hdl

hdl: ./gen.tcl
	$(VIVADO) -source ./gen.tcl

clean:
	rm -rf */*.hw */*.cache/ */*.ip_user_files/ */*.runs/ */*.sim/ */*.xpr *.jou *.log
