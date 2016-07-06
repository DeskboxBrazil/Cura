set(CMAKE_LEGACY_CYGWIN_WIN32 1)

project(cura)
cmake_minimum_required(VERSION 2.8.12)

#find_package(ECM REQUIRED NO_MODULE)
#set(CMAKE_MODULE_PATH ${ECM_MODULE_DIR})

# Build Translations
find_package(Gettext REQUIRED)
include(ECMPoQmTools.cmake)

# translations target will convert .po files into .mo and .qm as needed.
# The files are checked for a _qt suffix and if it is found, converted to
# qm, otherwise they are converted to .po.
add_custom_target(translations ALL)

#TODO: Properly install the built files. This should be done after we move the applications out of the Uranium repo.
set(languages
    en
    pt
    es
)
foreach(lang ${languages})
    file(GLOB po_files resources/i18n/${lang}/*.po)
    foreach(file ${po_files})
        string(REGEX MATCH "qt\\.po$" match "${file}")
        if(match)
            ecm_process_po_files_as_qm(${lang} ALL INSTALL_DESTINATION "${CMAKE_SOURCE_DIR}/resources/i18n" PO_FILES ${file})
        else()
            string(REGEX REPLACE "(.*)/(.*).po" "\\2.mo" mofile ${file})
            # message("file=${file}")
            # message("mofile=${mofile}")
            # message("WORKING_DIRECTORY=${CMAKE_SOURCE_DIR}/resources/i18n/${lang}")
            # message("LC_MESSAGES=${CMAKE_SOURCE_DIR}/resources/i18n/${lang}/LC_MESSAGES")
            # message("output=${CMAKE_SOURCE_DIR}/resources/i18n/${lang}/LC_MESSAGES/${mofile}")
            add_custom_command(
                TARGET translations POST_BUILD
                WORKING_DIRECTORY "${CMAKE_SOURCE_DIR}/resources/i18n/${lang}"
                COMMAND ${CMAKE_COMMAND} ARGS -E make_directory "LC_MESSAGES"
                COMMAND ${GETTEXT_MSGFMT_EXECUTABLE} ARGS ${file} -o "LC_MESSAGES/${mofile}"
            )
        endif()
    endforeach()
endforeach()

include(GNUInstallDirs)
find_package(PythonInterp 3.4.0 REQUIRED)

install(DIRECTORY resources DESTINATION ${CMAKE_INSTALL_DATADIR}/cura)
install(DIRECTORY plugins DESTINATION lib/cura)
install(FILES cura_app.py DESTINATION ${CMAKE_INSTALL_BINDIR} PERMISSIONS OWNER_READ OWNER_WRITE OWNER_EXECUTE GROUP_READ GROUP_EXECUTE WORLD_READ WORLD_EXECUTE)
if(NOT APPLE AND NOT WIN32)
    install(DIRECTORY cura DESTINATION lib/python${PYTHON_VERSION_MAJOR}/dist-packages)
    install(FILES cura.desktop DESTINATION ${CMAKE_INSTALL_DATADIR}/applications)
else()
    install(DIRECTORY cura DESTINATION lib/python${PYTHON_VERSION_MAJOR}.${PYTHON_VERSION_MINOR}/site-packages)
endif()
