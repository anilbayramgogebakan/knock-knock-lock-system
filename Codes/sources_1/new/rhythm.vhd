library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity rhythm is
    generic(
        bit_len : integer := 256;
        seq_len : integer := 6;
        sample_half_period : integer := 50000
    );
    Port(
        clk_100MHz : in STD_LOGIC;
        btn : in STD_LOGIC;
        res: in STD_LOGIC;
        pass: in STD_LOGIC;
        sequence_leds : out STD_LOGIC_VECTOR(1 to seq_len);
        password_leds : out STD_LOGIC_VECTOR(1 to seq_len);
        sync_led : out STD_LOGIC;
        lock_led : out STD_LOGIC
    );
end rhythm;

architecture Behavioral of rhythm is

component clock_div is port(clk_100MHz : in STD_LOGIC; half_period : in integer; clk_out : out STD_lOGIC);
end component;

constant sample_len : integer := bit_len * seq_len;  -- bit_len x seq_len

signal clk_1ms : STD_LOGIC;
signal clk_sync : STD_LOGIC;
signal samples : STD_LOGIC_VECTOR(1 to sample_len);
signal password : STD_LOGIC_VECTOR(1 to seq_len);
signal sequence : STD_LOGIC_VECTOR(1 to seq_len);
signal lock : STD_LOGIC := '0';

signal prev_btn : STD_LOGIC;

begin

clk_div : clock_div port map(clk_100MHz, sample_half_period, clk_1ms);
clk_div_sync : clock_div port map(clk_100MHz, bit_len * sample_half_period, clk_sync);


password_leds <= password;
sequence_leds <= sequence;
sync_led <= clk_sync;
lock_led <= lock;


process(clk_1ms) begin
    if rising_edge(clk_1ms) then
        prev_btn <= btn;
        samples(2 to sample_len) <= samples(1 to sample_len - 1);
        samples(1) <= (btn AND NOT prev_btn);

        if pass = '1' and lock = '1' then
             password <= sequence;
        end if;
        if password = sequence then
            lock <= '1';
        elsif res = '1' then
            lock <= '0';
        end if;
    end if;
end process;

process(samples)
variable temp : STD_LOGIC_VECTOR(1 to seq_len);
begin
    for i in 1 to seq_len loop
        temp(i) := '0';
        for j in 1 to bit_len loop
            temp(i) := temp(i) or samples( bit_len * (i-1) + j );
        end loop;
    sequence(i) <= temp(i);
    end loop;
end process;

end Behavioral;
