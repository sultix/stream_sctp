package stream_sctp.simulations;

import inet.applications.netperfmeter.NetPerfMeterHost;
import inet.networklayer.configurator.ipv4.FlatNetworkConfigurator;
import inet.networklayer.configurator.ipv4.IPv4NetworkConfigurator;
import inet.node.inet.Router;
import inet.node.inet.StandardHost;
import ned.DatarateChannel;


@license(LGPL);

network StreamSctp
{
    @display("bgb=797,414");
    types:
        channel ppp1line extends DatarateChannel
        {
            delay = 5ms;
            datarate = 100Mbps;
        }
        channel ppp1lineBetweenRouters extends DatarateChannel
        {
            delay = 5ms;
            datarate = 100Mbps;
            per = 0;
        }
    submodules:
        router1: Router {
            @display("p=273,199");
            gates:
                pppg[2];
        }
        router2: Router {
            @display("p=503,199");
            gates:
                pppg[2];
        }
        configurator: IPv4NetworkConfigurator {
            @display("p=37,31");
        }
        host1: NetPerfMeterHost {
            @display("p=37,199");
            gates:
                pppg[1];
        }
        host2: NetPerfMeterHost {
            @display("p=737,199");
            gates:
                pppg[1];
        }
    connections:
        host1.pppg[0] <--> ppp1line <--> router1.pppg[0];
        router1.pppg[1] <--> ppp1lineBetweenRouters <--> router2.pppg[0];
        router2.pppg[1] <--> ppp1line <--> host2.pppg[0];
}
