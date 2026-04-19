# IDAPython script, executed by the tool `py_exec_file` on `ida-pro-mcp`

from pathlib import Path

import idautils
import idc

output_dir = Path(__file__).resolve().parent / "resources" / "functions_list"
out_path = output_dir / f"{idc.get_root_filename()}.txt"

funcs = []
for ea in idautils.Functions():
  name = idc.get_func_name(ea)
  funcs.append(f"{hex(ea)}: {name}\n")

if funcs:
  output_dir.mkdir(parents=True, exist_ok=True)
  with open(out_path, "w") as f:
    f.writelines(funcs)
