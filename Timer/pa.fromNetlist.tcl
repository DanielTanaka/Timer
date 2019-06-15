
# PlanAhead Launch Script for Post-Synthesis floorplanning, created by Project Navigator

create_project -name v1 -dir "C:/Users/ra00184038/Documents/Timer/Timer/Timer/planAhead_run_3" -part xc3s100ecp132-4
set_property design_mode GateLvl [get_property srcset [current_run -impl]]
set_property edif_top_file "C:/Users/ra00184038/Documents/Timer/Timer/Timer/top.ngc" [ get_property srcset [ current_run ] ]
add_files -norecurse { {C:/Users/ra00184038/Documents/Timer/Timer/Timer} }
set_property target_constrs_file "pinagem.ucf" [current_fileset -constrset]
add_files [list {pinagem.ucf}] -fileset [get_property constrset [current_run]]
link_design
