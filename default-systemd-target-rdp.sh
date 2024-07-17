#
# Copyright (C) 2024  Red Hat, Inc.
#
# This copyrighted material is made available to anyone wishing to use,
# modify, copy, or redistribute it subject to the terms and conditions of
# the GNU General Public License v.2, or (at your option) any later version.
# This program is distributed in the hope that it will be useful, but WITHOUT
# ANY WARRANTY expressed or implied, including the implied warranties of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General
# Public License for more details.  You should have received a copy of the
# GNU General Public License along with this program; if not, write to the
# Free Software Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA
# 02110-1301, USA.  Any Red Hat trademarks that are incorporated in the
# source code or documentation are not subject to the GNU General Public
# License and may only be used or replicated with the express permission of
# Red Hat, Inc.
#
# Red Hat Author(s): Martin Kolman <mkolman@redhat.com>

# Ignore unused variable parsed out by tooling scripts as test tags metadata
# shellcheck disable=SC2034
TESTTYPE="services skip-on-fedora skip-on-rhel-8 skip-on-rhel-9"

. ${KSTESTDIR}/functions.sh
. ${KSTESTDIR}/validate-lib-services.sh

kernel_args() {
    echo ${DEFAULT_BOOTOPTS} inst.rdp inst.rdp.username=user inst.rdp.password=12345
}

validate() {
    # check output kickstart via validation library function
    validate_skipx_in_ks $1
    if [[ $? != 0 ]]; then
        cat ${1}/RESULT
        return 1
    fi

    validate_RESULT ${disksdir}
    return $?
}