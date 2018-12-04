#!/bin/bash


usage () {

    echo '''Usage:

         docker run <container> "Eat dog turds, you oompa loompa!"
         docker run -v $PWD:/data <container> /data/greeting.txt

         Commands:

                help: show help and exit
                list: list available templates
                all: run through ALL the templates (mrahaha)
                
         Options:

                --message:      Select one or more random messages
                --message-file: The file of messages to choose from
                --template:     choose the template that you want
                --no-color:     disable color output (you scrooge!)
                --sleep:        if you use all, the break between prints

         Examples:

             docker run <container> -t dog "I am a dog"
             docker run <container> -t santa greeting.txt
             docker run <container> all WHAT IS GOING ON
             docker run <container> Gogo gadget unibrow!
             docker run <container> Gogo gadget unibrow!
             docker run -v $PWD:/data <container> --message-file /data/insults.txt 
         '''
}

list_templates () {

    echo "See https://github.com/ascii-boxes/boxes/blob/master/boxes-config
          ================================================================="
            
    for template in ${templates[@]}; do
        echo ${template};
    done
}

validate_exists () {

    BOXES_MESSAGE_FILE=${1:-}
    if [ ! -f "${BOXES_MESSAGE_FILE}" ]; then
        echo "${BOXES_MESSAGE_FILE} does not exist!"
        exit 1
    fi

}

select_message () {

    BOXES_MESSAGE_FILE=${1:-}
    shuf -n 1 ${BOXES_MESSAGE_FILE}
}


generate_magic() {

    BOXES_INPUT=${1:-}
    BOXES_TEMPLATE=${2:-}
    BOXES_COLORS=${3:-}

    if [ "${BOXES_COLORS}" == "yes" ]; then
        SELECTED_COLOR=${colors[$RANDOM % ${#colors[@]} ]}
        echo -e $SELECTED_COLOR;
    fi

    # If it's not a file, assume it's a string
    if [ ! -f "${BOXES_INPUT}" ]; then
        echo ${BOXES_INPUT} | boxes -d ${BOXES_TEMPLATE} -a c;

    # It's a file, cat that thing.
    else
        cat ${BOXES_INPUT} | boxes -d ${BOXES_TEMPLATE} -a c;
    fi

    # Turn off the color
    if [ "${BOXES_COLORS}" == "yes" ]; then
        echo -e "\033[0m";
    fi


}

if [ $# -eq 0 ]; then
    usage
    exit
fi

################################################################################
# Default Variables
################################################################################

# From https://github.com/ascii-boxes/boxes/blob/master/boxes-config 12/2/2018

templates=(ada-box ada-cmt boxquote boy c c-cmt c-cmt2 c-cmt3 caml capgirl cat cc ccel columns diamonds dog face girl headline html html-cmt java-cmt javadoc lisp-cmt mouse netdata nuke parchment peek pound-cmt retest right santa scroll scroll-akn shell simple spring stark1 stark2 stone sunset test1 test2 test3 test4 test5 test6 tex-box tex-cmt tjc twisted underline unicornsay unicornthink vim-cmt whirly xes)

       # purple     yellow     red        darkred    cyan
colors=("\033[95m" "\033[93m" "\033[91m" "\033[31m" "\033[36m")

BOXES_TEMPLATE=""
BOXES_ALL="no"
BOXES_COLORS="yes"
BOXES_SLEEP=1.5
BOXES_MESSAGE="no"
BOXES_MESSAGE_FILE="/messages.txt"

while true; do
    case ${1:-} in
        -h|--help|help)
            usage
            exit
        ;;
        --all|-a|all)
            shift
            BOXES_ALL="yes"
        ;;       
        --message|-m)
            shift
            BOXES_MESSAGE="yes"
        ;;       
        --no-color)
            shift
            BOXES_COLORS="no"
        ;;
        --sleep)
            shift
            BOXES_SLEEP=${1:-}
            shift
        ;;
        --template|t|-t)
            shift
            BOXES_TEMPLATE=${1:-}
            shift
        ;;
        --messages-file|--message-file)
            shift
            BOXES_MESSAGE_FILE=${1:-}
            shift
        ;;
        --list|list|-l)
            list_templates;
            exit 0;
        ;;
        -*)
            echo "Unknown option: ${1:-}"
            exit 1
        ;;
        *)
            break
        ;;
    esac
done

# If the user selected a template, turn off all
if [ "${BOXES_TEMPLATE}" != "" ]; then
    BOXES_ALL="no";
fi

BOXES_INPUT="${@}"

if [ "${BOXES_ALL}" == "yes" ]; then
 
    # Show ALL the templates, with some break
    for template in ${templates[@]}; do

        # Should we select a random message?
        if [ ${BOXES_MESSAGE} == "yes" ]; then
            validate_exists ${BOXES_MESSAGE_FILE}
            BOXES_INPUT=$(select_message ${BOXES_MESSAGE_FILE});
        fi

        generate_magic "${BOXES_INPUT}" "${template}" "${BOXES_COLORS}"
        sleep $BOXES_SLEEP;
    done
    
else
    # Should we select a random message?
    if [ ${BOXES_MESSAGE} == "yes" ]; then
        validate_exists ${BOXES_MESSAGE_FILE}
        BOXES_INPUT=$(select_message ${BOXES_MESSAGE_FILE});
    fi

    # If we don't have a template, select one
    if [ "${BOXES_TEMPLATE}" == "" ]; then
        BOXES_TEMPLATE=${templates[$RANDOM % ${#templates[@]} ]}
    fi
    generate_magic "${BOXES_INPUT}" "${BOXES_TEMPLATE}" "${BOXES_COLORS}"
fi
