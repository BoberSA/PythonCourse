import itertools
from typing import Dict, Iterator


class Scanner:
    """Holds the state of a single scanner."""
    def __init__(self, layer: int, range_: int):
        self.layer = layer
        self.range_ = range_
        self.pos = 0
        self.dir_ = 'down'

    def advance(self):
        """Advance this scanner one time step."""
        if self.dir_ == 'down':
            self.pos += 1
            if self.pos == self.range_ - 1:
                self.dir_ = 'up'
        else:
            self.pos -= 1
            if self.pos == 0:
                self.dir_ = 'down'

    def copy(self):
        """Make a copy of this scanner in the same state."""
        inst = self.__class__(self.layer, self.range_)
        inst.pos = self.pos
        inst.dir_ = self.dir_
        return inst


def init_firewall(rows: Iterator[str]) -> Dict[int, Scanner]:
    """Create a dictionary of scanners from the puzzle input."""
    firewall = {}
    for row in rows:
        layer, range_ = (int(x) for x in row.split(': '))
        firewall[layer] = Scanner(layer, range_)
    return firewall


def puzzle_input() -> Dict[int, Scanner]:
    """Helper for loading puzzle input."""
    with open('input.txt') as f:
        return init_firewall(f)


def caught_crossing(
        firewall: Dict[int, Scanner], width: int) -> bool:
    """Returns True if the packet is caught while crossing, otherwise False."""
    for packet_pos in range(width):
        # check if the scanner is captured in this position
        if packet_pos in firewall and firewall[packet_pos].pos == 0:
            return True

        # advance scanners to their next positions
        for scanner in firewall.values():
            scanner.advance()

    return False


def copy_firewall(
        firewall: Dict[int, Scanner]) -> Dict[int, Scanner]:
    """Make a copy of a firewall dictionary"""
    return {
        layer: scanner.copy() for layer, scanner in firewall.items()
    }


def find_start(firewall: Dict[int, Scanner]) -> int:
    """Attempt crossing until we make it uncaught."""
    loop_firewall = copy_firewall(firewall)
    width = max(firewall.keys()) + 1

    for t_start in itertools.count(0):
        # save the state of the firewall before we start to cross
        # so we can use it as the basis of a potential next attempt
        pre_check_firewall = copy_firewall(loop_firewall)

        # check if the packet is caught while attempting a crossing starting
        # at this time step
        if caught_crossing(loop_firewall, width):
            # reset to pre-check state and advance once
            # so we can attempt a crossing at the next timestep
            loop_firewall = copy_firewall(pre_check_firewall)
            for scanner in loop_firewall.values():
                scanner.advance()
        else:
            break

    return t_start


print(find_start(puzzle_input()))