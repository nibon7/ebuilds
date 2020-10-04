# Copyright 1999-2020 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit go-module systemd

MY_PN="${PN}-core"
MY_P="${MY_PN}-${PV}"

_GOMODULE_GOPROXY_BASEURI="https://goproxy.baidu.com/"
EGO_SUM=(
	"cloud.google.com/go v0.26.0/go.mod h1:aQUYkXzVsufM+DwF1aE+0xfcU+56JwCaLick0ClmMTw="
	"github.com/BurntSushi/toml v0.3.1/go.mod h1:xHWCNGjB5oqiDr8zfno3MHue2Ht5sIBksp03qcyfWMU="
	"github.com/census-instrumentation/opencensus-proto v0.2.1/go.mod h1:f6KPmirojxKA12rnyqOA5BBL4O983OfeGPqjHWSTneU="
	"github.com/chzyer/logex v1.1.10/go.mod h1:+Ywpsq7O8HXn0nuIou7OrIPyXbp3wmkHB+jjWRnGsAI="
	"github.com/chzyer/readline v0.0.0-20180603132655-2972be24d48e/go.mod h1:nSuG5e5PlCu98SY8svDHJxuZscDgtXS6KTTbou5AhLI="
	"github.com/chzyer/test v0.0.0-20180213035817-a1ea475d72b1/go.mod h1:Q3SI9o4m/ZMnBNeIyt5eFwwo7qiLfzFZmjNmxjkiQlU="
	"github.com/client9/misspell v0.3.4/go.mod h1:qj6jICC3Q7zFZvVWo7KLAzC3yx5G7kyvSDkc90ppPyw="
	"github.com/cncf/udpa/go v0.0.0-20191209042840-269d4d468f6f/go.mod h1:M8M6+tZqaGXZJjfX53e64911xZQV5JYwmTeXPW+k8Sc="
	"github.com/davecgh/go-spew v1.1.0 h1:ZDRjVQ15GmhC3fiQ8ni8+OwkZQO4DARzQgrnXU1Liz8="
	"github.com/davecgh/go-spew v1.1.0/go.mod h1:J7Y8YcW2NihsgmVo/mv3lAwl/skON4iLHjSsI+c5H38="
	"github.com/dgryski/go-metro v0.0.0-20200812162917-85c65e2d0165 h1:BS21ZUJ/B5X2UVUbczfmdWH7GapPWAhxcMsDnjJTU1E="
	"github.com/dgryski/go-metro v0.0.0-20200812162917-85c65e2d0165/go.mod h1:c9O8+fpSOX1DM8cPNSkX/qsBWdkD4yd2dpciOWQjpBw="
	"github.com/ebfe/bcrypt_pbkdf v0.0.0-20140212075826-3c8d2dcb253a h1:YtdtTUN1iH97s+6PUjLnaiKSQj4oG1/EZ3N9bx6g4kU="
	"github.com/ebfe/bcrypt_pbkdf v0.0.0-20140212075826-3c8d2dcb253a/go.mod h1:/CZpbhAusDOobpcb9yubw46kdYjq0zRC0Wpg9a9zFQM="
	"github.com/envoyproxy/go-control-plane v0.9.0/go.mod h1:YTl/9mNaCwkRvm6d1a2C3ymFceY/DCBVvsKhRF0iEA4="
	"github.com/envoyproxy/go-control-plane v0.9.1-0.20191026205805-5f8ba28d4473/go.mod h1:YTl/9mNaCwkRvm6d1a2C3ymFceY/DCBVvsKhRF0iEA4="
	"github.com/envoyproxy/go-control-plane v0.9.4/go.mod h1:6rpuAdCZL397s3pYoYcLgu1mIlRU8Am5FuJP05cCM98="
	"github.com/envoyproxy/protoc-gen-validate v0.1.0/go.mod h1:iSmxcyjqTsJpI2R4NaDN7+kN2VEUnK/pcBlmesArF7c="
	"github.com/golang/glog v0.0.0-20160126235308-23def4e6c14b/go.mod h1:SBH7ygxi8pfUlaOkMMuAQtPIUF8ecWP5IEl/CR7VP2Q="
	"github.com/golang/mock v1.1.1/go.mod h1:oTYuIxOrZwtPieC+H1uAHpcLFnEyAGVDL/k47Jfbm0A="
	"github.com/golang/mock v1.4.4 h1:l75CXGRSwbaYNpl/Z2X1XIIAMSCquvXgpVZDhwEIJsc="
	"github.com/golang/mock v1.4.4/go.mod h1:l3mdAwkq5BuhzHwde/uurv3sEJeZMXNpwsxVWU71h+4="
	"github.com/golang/protobuf v1.2.0/go.mod h1:6lQm79b+lXiMfvg/cZm0SGofjICqVBUtrP5yJMmIC1U="
	"github.com/golang/protobuf v1.3.2/go.mod h1:6lQm79b+lXiMfvg/cZm0SGofjICqVBUtrP5yJMmIC1U="
	"github.com/golang/protobuf v1.3.3/go.mod h1:vzj43D7+SQXF/4pzW/hwtAqwc6iTitCiVSaWz5lYuqw="
	"github.com/golang/protobuf v1.4.0-rc.1/go.mod h1:ceaxUfeHdC40wWswd/P6IGgMaK3YpKi5j83Wpe3EHw8="
	"github.com/golang/protobuf v1.4.0-rc.1.0.20200221234624-67d41d38c208/go.mod h1:xKAWHe0F5eneWXFV3EuXVDTCmh+JuBKY0li0aMyXATA="
	"github.com/golang/protobuf v1.4.0-rc.2/go.mod h1:LlEzMj4AhA7rCAGe4KMBDvJI+AwstrUpVNzEA03Pprs="
	"github.com/golang/protobuf v1.4.0-rc.4.0.20200313231945-b860323f09d0/go.mod h1:WU3c8KckQ9AFe+yFwt9sWVRKCVIyN9cPHBJSNnbL67w="
	"github.com/golang/protobuf v1.4.0/go.mod h1:jodUvKwWbYaEsadDk5Fwe5c77LiNKVO9IDvqG2KuDX0="
	"github.com/golang/protobuf v1.4.1/go.mod h1:U8fpvMrcmy5pZrNK1lt4xCsGvpyWQ/VVv6QDs8UjoX8="
	"github.com/golang/protobuf v1.4.2 h1:+Z5KGCizgyZCbGh1KZqA0fcLLkwbsjIzS4aV2v7wJX0="
	"github.com/golang/protobuf v1.4.2/go.mod h1:oDoupMAO8OvCJWAcko0GGGIgR6R6ocIYbsSw735rRwI="
	"github.com/google/go-cmp v0.2.0/go.mod h1:oXzfMopK8JAjlY9xF4vHSVASa0yLyX7SntLO5aqRK0M="
	"github.com/google/go-cmp v0.3.0/go.mod h1:8QqcDgzrUqlUb/G2PQTWiueGozuR1884gddMywk6iLU="
	"github.com/google/go-cmp v0.3.1/go.mod h1:8QqcDgzrUqlUb/G2PQTWiueGozuR1884gddMywk6iLU="
	"github.com/google/go-cmp v0.4.0/go.mod h1:v8dTdLbMG2kIc/vJvl+f65V22dbkXbowE6jgT/gNBxE="
	"github.com/google/go-cmp v0.5.0/go.mod h1:v8dTdLbMG2kIc/vJvl+f65V22dbkXbowE6jgT/gNBxE="
	"github.com/google/go-cmp v0.5.2 h1:X2ev0eStA3AbceY54o37/0PQ/UWqKEiiO2dKL5OPaFM="
	"github.com/google/go-cmp v0.5.2/go.mod h1:v8dTdLbMG2kIc/vJvl+f65V22dbkXbowE6jgT/gNBxE="
	"github.com/gorilla/websocket v1.4.2 h1:+/TMaTYc4QFitKJxsQ7Yye35DkWvkdLcvGKqM+x0Ufc="
	"github.com/gorilla/websocket v1.4.2/go.mod h1:YR8l580nyteQvAITg2hZ9XVh4b55+EU/adAjf1fMHhE="
	"github.com/h12w/go-socks5 v0.0.0-20200522160539-76189e178364 h1:5XxdakFhqd9dnXoAZy1Mb2R/DZ6D1e+0bGC/JhucGYI="
	"github.com/h12w/go-socks5 v0.0.0-20200522160539-76189e178364/go.mod h1:eDJQioIyy4Yn3MVivT7rv/39gAJTrA7lgmYr8EW950c="
	"github.com/miekg/dns v1.1.31 h1:sJFOl9BgwbYAWOGEwr61FU28pqsBNdpRBnhGXtO06Oo="
	"github.com/miekg/dns v1.1.31/go.mod h1:KNUDUusw/aVsxyTYZM1oqvCicbwhgbNgztCETuNZ7xM="
	"github.com/phayes/freeport v0.0.0-20180830031419-95f893ade6f2 h1:JhzVVoYvbOACxoUmOs6V/G4D5nPVUW73rKvXxP4XUJc="
	"github.com/phayes/freeport v0.0.0-20180830031419-95f893ade6f2/go.mod h1:iIss55rKnNBTvrwdmkUpLnDpZoAHvWaiq5+iMmen4AE="
	"github.com/pires/go-proxyproto v0.1.3 h1:2XEuhsQluSNA5QIQkiUv8PfgZ51sNYIQkq/yFquiSQM="
	"github.com/pires/go-proxyproto v0.1.3/go.mod h1:Odh9VFOZJCf9G8cLW5o435Xf1J95Jw9Gw5rnCjcwzAY="
	"github.com/pmezard/go-difflib v1.0.0 h1:4DBwDE0NGyQoBHbLQYPwSUPoCMWR5BEzIk/f1lZbAQM="
	"github.com/pmezard/go-difflib v1.0.0/go.mod h1:iKH77koFhYxTK1pcRnkKkqfTogsbg7gZNVY4sRDYZ/4="
	"github.com/prometheus/client_model v0.0.0-20190812154241-14fe0d1b01d4/go.mod h1:xMI15A0UPsDsEKsMN9yxemIoYk6Tm2C1GtYGdfGttqA="
	"github.com/seiflotfy/cuckoofilter v0.0.0-20200511222245-56093a4d3841 h1:pnfutQFsV7ySmHUeX6ANGfPsBo29RctUvDn8G3rmJVw="
	"github.com/seiflotfy/cuckoofilter v0.0.0-20200511222245-56093a4d3841/go.mod h1:ET5mVvNjwaGXRgZxO9UZr7X+8eAf87AfIYNwRSp9s4Y="
	"github.com/stretchr/objx v0.1.0/go.mod h1:HFkY916IF+rwdDfMAkV7OtwuqBVzrE8GR6GFx+wExME="
	"github.com/stretchr/testify v1.6.1 h1:hDPOHmpOpP40lSULcqw7IrRb/u7w6RpDC9399XyoNd0="
	"github.com/stretchr/testify v1.6.1/go.mod h1:6Fq8oRcR53rry900zMqJjRRixrwX3KX962/h/Wwjteg="
	"github.com/xiaokangwang/VSign v0.0.0-20200828155424-dc1c86b73fbf h1:d4keT3SwLbrgnEe2zbtijPLgKE15n0ZbvJZzRH/a9GM="
	"github.com/xiaokangwang/VSign v0.0.0-20200828155424-dc1c86b73fbf/go.mod h1:jTwBnzBuqZP3VX/Z65ErYb9zd4anQprSC7N38TmAp1E="
	"go.starlark.net v0.0.0-20200901195727-6e684ef5eeee h1:N4eRtIIYHZE5Mw/Km/orb+naLdwAe+lv2HCxRR5rEBw="
	"go.starlark.net v0.0.0-20200901195727-6e684ef5eeee/go.mod h1:f0znQkUKRrkk36XxWbGjMqQM8wGv/xHBVE2qc3B5oFU="
	"golang.org/x/crypto v0.0.0-20190308221718-c2843e01d9a2/go.mod h1:djNgcEr1/C05ACkg1iLfiJU5Ep61QUkGW8qpdssI0+w="
	"golang.org/x/crypto v0.0.0-20191011191535-87dc89f01550/go.mod h1:yigFU9vqHzYiE8UmvKecakEJjdnWj3jj499lnFckfCI="
	"golang.org/x/crypto v0.0.0-20200622213623-75b288015ac9/go.mod h1:LzIPMQfyMNhhGPhUkYOs5KpL4U8rLKemX1yGLhDgUto="
	"golang.org/x/crypto v0.0.0-20200820211705-5c72a883971a h1:vclmkQCjlDX5OydZ9wv8rBCcS0QyQY66Mpf/7BZbInM="
	"golang.org/x/crypto v0.0.0-20200820211705-5c72a883971a/go.mod h1:LzIPMQfyMNhhGPhUkYOs5KpL4U8rLKemX1yGLhDgUto="
	"golang.org/x/exp v0.0.0-20190121172915-509febef88a4/go.mod h1:CJ0aWSM057203Lf6IL+f9T1iT9GByDxfZKAQTCR3kQA="
	"golang.org/x/lint v0.0.0-20181026193005-c67002cb31c3/go.mod h1:UVdnD1Gm6xHRNCYTkRU2/jEulfH38KcIWyp/GAMgvoE="
	"golang.org/x/lint v0.0.0-20190227174305-5b3e6a55c961/go.mod h1:wehouNa3lNwaWXcvxsM5YxQ5yQlVC4a0KAMCusXpPoU="
	"golang.org/x/lint v0.0.0-20190313153728-d0100b6bd8b3/go.mod h1:6SW0HCj/g11FgYtHlgUYUwCkIfeOF89ocIRzGO/8vkc="
	"golang.org/x/mod v0.1.1-0.20191105210325-c90efee705ee/go.mod h1:QqPTAvyqsEbceGzBzNggFXnrqF1CaUcvgkdR5Ot7KZg="
	"golang.org/x/net v0.0.0-20180724234803-3673e40ba225/go.mod h1:mL1N/T3taQHkDXs73rZJwtUhF3w3ftmwwsq0BUmARs4="
	"golang.org/x/net v0.0.0-20180826012351-8a410e7b638d/go.mod h1:mL1N/T3taQHkDXs73rZJwtUhF3w3ftmwwsq0BUmARs4="
	"golang.org/x/net v0.0.0-20190213061140-3a22650c66bd/go.mod h1:mL1N/T3taQHkDXs73rZJwtUhF3w3ftmwwsq0BUmARs4="
	"golang.org/x/net v0.0.0-20190311183353-d8887717615a/go.mod h1:t9HGtf8HONx5eT2rtn7q6eTqICYqUVnKs3thJo3Qplg="
	"golang.org/x/net v0.0.0-20190404232315-eb5bcb51f2a3/go.mod h1:t9HGtf8HONx5eT2rtn7q6eTqICYqUVnKs3thJo3Qplg="
	"golang.org/x/net v0.0.0-20190620200207-3b0461eec859/go.mod h1:z5CRVTTTmAJ677TzLLGU+0bjPO0LkuOLi4/5GtJWs/s="
	"golang.org/x/net v0.0.0-20190923162816-aa69164e4478/go.mod h1:z5CRVTTTmAJ677TzLLGU+0bjPO0LkuOLi4/5GtJWs/s="
	"golang.org/x/net v0.0.0-20200822124328-c89045814202 h1:VvcQYSHwXgi7W+TpUR6A9g6Up98WAHf3f/ulnJ62IyA="
	"golang.org/x/net v0.0.0-20200822124328-c89045814202/go.mod h1:/O7V0waA8r7cgGh81Ro3o1hOxt32SMVPicZroKQ2sZA="
	"golang.org/x/oauth2 v0.0.0-20180821212333-d2e6202438be/go.mod h1:N/0e6XlmueqKjAGxoOufVs8QHGRruUQn6yWY3a++T0U="
	"golang.org/x/sync v0.0.0-20180314180146-1d60e4601c6f/go.mod h1:RxMgew5VJxzue5/jJTE5uejpjVlOe/izrB70Jof72aM="
	"golang.org/x/sync v0.0.0-20181108010431-42b317875d0f/go.mod h1:RxMgew5VJxzue5/jJTE5uejpjVlOe/izrB70Jof72aM="
	"golang.org/x/sync v0.0.0-20190423024810-112230192c58/go.mod h1:RxMgew5VJxzue5/jJTE5uejpjVlOe/izrB70Jof72aM="
	"golang.org/x/sync v0.0.0-20200625203802-6e8e738ad208 h1:qwRHBd0NqMbJxfbotnDhm2ByMI1Shq4Y6oRJo21SGJA="
	"golang.org/x/sync v0.0.0-20200625203802-6e8e738ad208/go.mod h1:RxMgew5VJxzue5/jJTE5uejpjVlOe/izrB70Jof72aM="
	"golang.org/x/sys v0.0.0-20180830151530-49385e6e1522/go.mod h1:STP8DvDyc/dI5b8T5hshtkjS+E42TnysNCUPdjciGhY="
	"golang.org/x/sys v0.0.0-20190215142949-d0b11bdaac8a/go.mod h1:STP8DvDyc/dI5b8T5hshtkjS+E42TnysNCUPdjciGhY="
	"golang.org/x/sys v0.0.0-20190412213103-97732733099d/go.mod h1:h1NjWce9XRLGQEsW7wpKNCjG9DtNlClVuFLEZdDNbEs="
	"golang.org/x/sys v0.0.0-20190924154521-2837fb4f24fe/go.mod h1:h1NjWce9XRLGQEsW7wpKNCjG9DtNlClVuFLEZdDNbEs="
	"golang.org/x/sys v0.0.0-20200323222414-85ca7c5b95cd/go.mod h1:h1NjWce9XRLGQEsW7wpKNCjG9DtNlClVuFLEZdDNbEs="
	"golang.org/x/sys v0.0.0-20200625212154-ddb9806d33ae/go.mod h1:h1NjWce9XRLGQEsW7wpKNCjG9DtNlClVuFLEZdDNbEs="
	"golang.org/x/sys v0.0.0-20200831180312-196b9ba8737a h1:i47hUS795cOydZI4AwJQCKXOr4BvxzvikwDoDtHhP2Y="
	"golang.org/x/sys v0.0.0-20200831180312-196b9ba8737a/go.mod h1:h1NjWce9XRLGQEsW7wpKNCjG9DtNlClVuFLEZdDNbEs="
	"golang.org/x/text v0.3.0 h1:g61tztE5qeGQ89tm6NTjjM9VPIm088od1l6aSorWRWg="
	"golang.org/x/text v0.3.0/go.mod h1:NqM8EUOU14njkJ3fqMW+pc6Ldnwhi/IjpwHt7yyuwOQ="
	"golang.org/x/tools v0.0.0-20190114222345-bf090417da8b/go.mod h1:n7NCudcB/nEzxVGmLbDWY5pfWTLqBcC2KZ6jyYvM4mQ="
	"golang.org/x/tools v0.0.0-20190226205152-f727befe758c/go.mod h1:9Yl7xja0Znq3iFh3HoIrodX9oNMXvdceNzlUR8zjMvY="
	"golang.org/x/tools v0.0.0-20190311212946-11955173bddd/go.mod h1:LCzVGOaR6xXOjkQ3onu1FJEFr0SW1gC7cKk1uF8kGRs="
	"golang.org/x/tools v0.0.0-20190425150028-36563e24a262/go.mod h1:RgjU9mgBXZiqYHBnxXauZ1Gv1EHHAz9KjViQ78xBX0Q="
	"golang.org/x/tools v0.0.0-20190524140312-2c0ae7006135/go.mod h1:RgjU9mgBXZiqYHBnxXauZ1Gv1EHHAz9KjViQ78xBX0Q="
	"golang.org/x/tools v0.0.0-20191216052735-49a3e744a425/go.mod h1:TB2adYChydJhpapKDTa4BR/hXlZSLoq2Wpct/0txZ28="
	"golang.org/x/xerrors v0.0.0-20191011141410-1b5146add898/go.mod h1:I/5z698sn9Ka8TeJc9MKroUUfqBBauWjQqLJ2OPfmY0="
	"golang.org/x/xerrors v0.0.0-20191204190536-9bdfabe68543 h1:E7g+9GITq07hpfrRu66IVDexMakfv52eLZ2CXBWiKr4="
	"golang.org/x/xerrors v0.0.0-20191204190536-9bdfabe68543/go.mod h1:I/5z698sn9Ka8TeJc9MKroUUfqBBauWjQqLJ2OPfmY0="
	"google.golang.org/appengine v1.1.0/go.mod h1:EbEs0AVv82hx2wNQdGPgUI5lhzA/G0D9YwlJXL52JkM="
	"google.golang.org/appengine v1.4.0/go.mod h1:xpcJRLb0r/rnEns0DIKYYv+WjYCduHsrkT7/EB5XEv4="
	"google.golang.org/genproto v0.0.0-20180817151627-c66870c02cf8/go.mod h1:JiN7NxoALGmiZfu7CAH4rXhgtRTLTxftemlI0sWmxmc="
	"google.golang.org/genproto v0.0.0-20190819201941-24fa4b261c55/go.mod h1:DMBHOl98Agz4BDEuKkezgsaosCRResVns1a3J2ZsMNc="
	"google.golang.org/genproto v0.0.0-20200526211855-cb27e3aa2013 h1:+kGHl1aib/qcwaRi1CbqBZ1rk19r85MNUf8HaBghugY="
	"google.golang.org/genproto v0.0.0-20200526211855-cb27e3aa2013/go.mod h1:NbSheEEYHJ7i3ixzK3sjbqSGDJWnxyFXZblF3eUsNvo="
	"google.golang.org/grpc v1.19.0/go.mod h1:mqu4LbDTu4XGKhr4mRzUsmM4RtVoemTSY81AxZiDr8c="
	"google.golang.org/grpc v1.23.0/go.mod h1:Y5yQAOtifL1yxbo5wqy6BxZv8vAUGQwXBOALyacEbxg="
	"google.golang.org/grpc v1.25.1/go.mod h1:c3i+UQWmh7LiEpx4sFZnkU36qjEYZ0imhYfXVyQciAY="
	"google.golang.org/grpc v1.27.0/go.mod h1:qbnxyOmOxrQa7FizSgH+ReBfzJrCY1pSN7KXBS8abTk="
	"google.golang.org/grpc v1.31.1 h1:SfXqXS5hkufcdZ/mHtYCh53P2b+92WQq/DZcKLgsFRs="
	"google.golang.org/grpc v1.31.1/go.mod h1:N36X2cJ7JwdamYAgDz+s+rVMFjt3numwzf/HckM8pak="
	"google.golang.org/grpc v1.32.0 h1:zWTV+LMdc3kaiJMSTOFz2UgSBgx8RNQoTGiZu3fR9S0="
	"google.golang.org/grpc v1.32.0/go.mod h1:N36X2cJ7JwdamYAgDz+s+rVMFjt3numwzf/HckM8pak="
	"google.golang.org/protobuf v0.0.0-20200109180630-ec00e32a8dfd/go.mod h1:DFci5gLYBciE7Vtevhsrf46CRTquxDuWsQurQQe4oz8="
	"google.golang.org/protobuf v0.0.0-20200221191635-4d8936d0db64/go.mod h1:kwYJMbMJ01Woi6D6+Kah6886xMZcty6N08ah7+eCXa0="
	"google.golang.org/protobuf v0.0.0-20200228230310-ab0ca4ff8a60/go.mod h1:cfTl7dwQJ+fmap5saPgwCLgHXTUD7jkjRqWcaiX5VyM="
	"google.golang.org/protobuf v1.20.1-0.20200309200217-e05f789c0967/go.mod h1:A+miEFZTKqfCUM6K7xSMQL9OKL/b6hQv+e19PK+JZNE="
	"google.golang.org/protobuf v1.21.0/go.mod h1:47Nbq4nVaFHyn7ilMalzfO3qCViNmqZ2kzikPIcrTAo="
	"google.golang.org/protobuf v1.22.0/go.mod h1:EGpADcykh3NcUnDUJcl1+ZksZNG86OlYog2l/sGQquU="
	"google.golang.org/protobuf v1.23.0/go.mod h1:EGpADcykh3NcUnDUJcl1+ZksZNG86OlYog2l/sGQquU="
	"google.golang.org/protobuf v1.23.1-0.20200526195155-81db48ad09cc/go.mod h1:EGpADcykh3NcUnDUJcl1+ZksZNG86OlYog2l/sGQquU="
	"google.golang.org/protobuf v1.25.0 h1:Ejskq+SyPohKW+1uil0JJMtmHCgJPJ/qWTxr8qp+R4c="
	"google.golang.org/protobuf v1.25.0/go.mod h1:9JNX74DMeImyA3h4bdi1ymwjUzf21/xIlbajtzgsN7c="
	"gopkg.in/check.v1 v0.0.0-20161208181325-20d25e280405 h1:yhCVgyC4o1eVCa2tZl7eS0r+SDo693bJlVdllGtEeKM="
	"gopkg.in/check.v1 v0.0.0-20161208181325-20d25e280405/go.mod h1:Co6ibVJAznAaIkqp8huTwlJQCZ016jof/cbN4VW5Yz0="
	"gopkg.in/yaml.v3 v3.0.0-20200313102051-9f266ea9e77c h1:dUUwHk2QECo/6vqA44rthZ8ie2QXMNeKRTHCNY2nXvo="
	"gopkg.in/yaml.v3 v3.0.0-20200313102051-9f266ea9e77c/go.mod h1:K4uyk7z7BCEPqu6E+C64Yfv1cQ7kz7rIZviUmN+EgEM="
	"h12.io/socks v1.0.1 h1:bXESSI/+hbdrp+22vcc7/JiXjmLH4UWktKdYgGr3ShA="
	"h12.io/socks v1.0.1/go.mod h1:AIhxy1jOId/XCz9BO+EIgNL2rQiPTBNnOfnVnQ+3Eck="
	"honnef.co/go/tools v0.0.0-20190102054323-c2f93a96b099/go.mod h1:rf3lG4BRIbNafJWhAfAdb/ePZxsR/4RtNHQocxwk9r4="
	"honnef.co/go/tools v0.0.0-20190523083050-ea95bdfd59fc/go.mod h1:rf3lG4BRIbNafJWhAfAdb/ePZxsR/4RtNHQocxwk9r4="
	)
go-module_set_globals

DESCRIPTION="A platform for building proxies to bypass network restrictions"
HOMEPAGE="https://www.v2ray.com/"
SRC_URI="https://github.com/v2ray/v2ray-core/archive/v${PV}/${MY_P}.tar.gz
	${EGO_SUM_SRC_URI}"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64"
IUSE=""

S="${WORKDIR}/${MY_P}"

src_compile() {
	export CGO_ENABLED=0
	export BUILDNAME=$(date '+%Y%m%d-%H%M%S')
	export LDFLAGS="-s -w -X v2ray.com/core.codename=${PN} -X v2ray.com/core.build=${BUILDNAME} -X v2ray.com/core.version=${PV}"

	go build -o bin/v2ray -ldflags "${LDFLAGS}" v2ray.com/core/main || die
	go build -o bin/v2ctl -tags confonly -ldflags "${LDFLAGS}" v2ray.com/core/infra/control/main || die
}

src_install() {
	dobin bin/v2ray
	dobin bin/v2ray

	pushd release/config || die
	sed -i -e 's#/usr/local/bin#/usr/bin#g' \
		-e 's#/usr/local/etc#/etc#g' \
		systemd/system/v2ray.service \
		systemd/system/v2ray@.service || die

	systemd_dounit systemd/system/v2ray.service
	systemd_dounit systemd/system/v2ray@.service

	insinto /usr/share/v2ray
	doins *.dat

	insinto /etc/v2ray
	doins *.json
	popd

	dodoc README.md
	newinitd "${FILESDIR}/v2ray.initd" v2ray
}