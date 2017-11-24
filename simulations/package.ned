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
    @display("bgb=561,322");
    types:
        channel ppp1line extends DatarateChannel
        {
            delay = 8ms;
            datarate = 1 Mbps;
            per = 0.5;
            ber = 0;
        }
    submodules:
        router1: Router {
            @display("p=267,72");
            gates:
                pppg[2];
        }
        router2: Router {
            @display("p=275,245");
        	gates:
                pppg[2];
        }
        configurator: IPv4NetworkConfigurator {
            @display("p=503,30");
        }
        host1: NetPerfMeterHost {
            @display("p=105,162");
        	gates:
                pppg[2];
        }
        host2: NetPerfMeterHost {
            @display("p=454,162");
            gates:
                pppg[2];
        }
    connections:
        host1.pppg[0] <--> ppp1line <--> router1.pppg[0];
        host1.pppg[1] <--> ppp1line <--> router2.pppg[0];
        
        host2.pppg[0] <--> ppp1line <--> router1.pppg[1];
        host2.pppg[1] <--> ppp1line <--> router2.pppg[1];
}
