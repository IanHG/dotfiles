#!/bin/bash
#--------------------------------------------------------------------
#
# arg_parse for bash scripts
#
#--------------------------------------------------------------------

#--------------------------------------------------------------------
# Setter function to set true
#--------------------------------------------------------------------
function set_true()
{
   input_variables[$1]=true
   return 0
}

#--------------------------------------------------------------------
# Setter function to set false
#--------------------------------------------------------------------
function set_false()
{
   input_variables[$1]=false
   return 0
}

#--------------------------------------------------------------------
# Setter function to set 1 arg
#--------------------------------------------------------------------
function set_one_arg()
{
   input_variables[$1]=$2
   return 1
}

#--------------------------------------------------------------------
# Wrapper function to call setter function with arguments
#--------------------------------------------------------------------
function call_with_args()
{
   $@
   return $?
}

#--------------------------------------------------------------------
# Parse arguments
#--------------------------------------------------------------------
function parse_arguments()
{
   do_shift=0

   while test $# -gt 0
   do
      case $1 in
         *)
            if [ ! -z ${input_functions["$1"]} ]; then
               call_with_args ${input_functions["$1"]} "$@"
               do_shift=$?
            else
               args=$args" ""$1"
            fi

            for i in $(seq 1 $do_shift); do 
               shift
            done
            ;;
      esac
      shift
   done
   
   if [ ! -z "$args" ]; then
      if [ "$arg_parse_print" == "true" ]; then
         echo "Did not parse : " $args
      fi
      if [ "$arg_parse_error" == "true" ]; then
         return 1
      fi
   fi

   return 0
}

#--------------------------------------------------------------------
#  Declare arrays
#     input_variables: Holds variables/arguments/keywords and default values
#     input_functions: Holds variables/arguments/keywords and function for reading
#--------------------------------------------------------------------
declare -A input_variables
declare -A input_functions
