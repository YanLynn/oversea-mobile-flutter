import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:borderlessWorking/style/theme.dart' as Style;

class PrivacyPolicyPage extends StatelessWidget {
  const PrivacyPolicyPage();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('プライバシーポリシー', style: TextStyle(color: Colors.white)),
        centerTitle: true,
        backgroundColor: Style.CustomColor.mainColor,       
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          onPressed: () {
            Navigator.of(context).pop();
            // Navigator.of(context).pushNamed('/');
          },
        ), 
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(25),
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.only(
                bottom: 15, // Space between underline and text
              ),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "プライバシーポリシー",
                  style: Style.Customstyles.h1,
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.only(bottom: 15.0),
              child: Text(
                "株式会社 TrustGrowth（以下「当社」といいます。）は、個人情報保護の重要性について認識し、個人情報の保護に関する法律（以下「個人情報保護法」といいます。）を遵守すると共に、以下のプライバシーポリシー（以下「本プライバシーポリシー」といいます。）に従い、適切な取扱い及び保護に努めます。なお、本プライバシーポリシーにおいて別段の定めがない限り、本プライバシーポリシーにおける用語の定義は、個人情報保護法の定めに従います。",
              ),
            ),
            Container(
              // color: Style.CustomColor.greylight,
              padding: EdgeInsets.all(10),
              decoration: Style.Customstyles.titleCardBoxDecoration,
              child: Row(
                children: <Widget>[Text("1 個人情報の定義")],
              ),
            ),
            SizedBox(height: 10.0),
            Container(
              padding: EdgeInsets.only(bottom: 20.0),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                    "本プライバシーポリシーにおいて、個人情報とは、個人情報保護法第 2 条第 1 項により定義される個人情報を意味するものとします。"),
              ),
            ),
            Container(
              // color: Style.CustomColor.greylight,
              padding: EdgeInsets.all(10),
              decoration: Style.Customstyles.titleCardBoxDecoration,
              child: Row(
                children: <Widget>[Text("2 個人情報の利用目的")],
              ),
            ),
            SizedBox(height: 10.0),
            Container(
              padding: EdgeInsets.only(bottom: 15.0),
              child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text("当社は、個人情報を以下の目的で利用いたします。")),
            ),
            Container(
              padding: EdgeInsets.only(bottom: 20.0),
              child: Align(
                alignment: Alignment.centerLeft,
                child: RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: '2.1 当社の提供する「ボーダレスワーキング',
                        style: TextStyle(color: Colors.black),
                      ),
                      TextSpan(
                        text: '（https://borderless-working.jp）',
                        style: TextStyle(color: Colors.blue),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            Navigator.of(context).popAndPushNamed('/');
                          },
                      ),
                      TextSpan(
                        text: '（以下「本サービス」といいます。）の提供のため\n' +
                            '2.2 本サービスの利用料金のご請求及び決済のため\n' +
                            '2.3 本サービスに関するご案内、お問い合せ等への対応のため\n' +
                            '2.4　当社の商品、サービス等のご案内のため\n' +
                            '2.5　各種キャンペーン、アンケート等への応募受け付け及び対象者への連絡、発送のため\n' +
                            '2.6　メールマガジン、お知らせなどの情報配信のため\n' +
                            '2.7　本サービスを安全に運営するための調査、検証等のため\n' +
                            '2.8　本サービスに関する当社の規約、ポリシー等（以下「規約等」といいます。）に違反する行為に対する対応のため\n' +
                            '2.9　本サービスに関する規約等の変更などを通知するため\n' +
                            '2.10　本サービスの改善、新サービスの開発等に役立てるため\n' +
                            '2.11　本サービスに関連して、個人を識別できない形式に加工した統計データを作成するため\n' +
                            '2.12　その他、上記利用目的に付随する目的のため',
                        style: TextStyle(color: Colors.black),
                      ),
                    ],
                  ),
                ),
                // Text(
                //     '2.1 当社の提供する「ボーダレスワーキング（https://borderless-working.jp）」（以下「本サービス」といいます。）の提供のため\n' +
                //         '2.2 本サービスの利用料金のご請求及び決済のため\n' +
                //         '2.3 本サービスに関するご案内、お問い合せ等への対応のため\n' +
                //         '2.4　当社の商品、サービス等のご案内のため\n' +
                //         '2.5　各種キャンペーン、アンケート等への応募受け付け及び対象者への連絡、発送のため\n' +
                //         '2.6　メールマガジン、お知らせなどの情報配信のため\n' +
                //         '2.7　本サービスを安全に運営するための調査、検証等のため\n' +
                //         '2.8　本サービスに関する当社の規約、ポリシー等（以下「規約等」といいます。）に違反する行為に対する対応のため\n' +
                //         '2.9　本サービスに関する規約等の変更などを通知するため\n' +
                //         '2.10　本サービスの改善、新サービスの開発等に役立てるため\n' +
                //         '2.11　本サービスに関連して、個人を識別できない形式に加工した統計データを作成するため\n' +
                //         '2.12　その他、上記利用目的に付随する目的のため'),
              ),
            ),
            Container(
              // color: Style.CustomColor.greylight,
              padding: EdgeInsets.all(10),
              decoration: Style.Customstyles.titleCardBoxDecoration,
              child: Row(
                children: <Widget>[Text("3 個人情報利用目的の変更")],
              ),
            ),
            SizedBox(height: 10.0),
            Container(
              padding: EdgeInsets.only(bottom: 20.0),
              child: Text(
                "当社は、個人情報の利用目的を関連性を有すると合理的に認められる範囲内において変更することがあり、変更した場合には個人情報の主体である個人（以下「本人」といいます。）に通知し又は公表します。",
              ),
            ),
            Container(
              // color: Style.CustomColor.greylight,
              padding: EdgeInsets.all(10),
              decoration: Style.Customstyles.titleCardBoxDecoration,
              child: Row(
                children: <Widget>[Text("4 個人情報利用の制限")],
              ),
            ),
            SizedBox(height: 10.0),
            Container(
              padding: EdgeInsets.only(bottom: 15.0),
              child: Text(
                "当社は、個人情報保護法その他の法令により許容される場合を除き、本人の同意を得ず、利用目的の達成に必要な範囲を超えて個人情報を取り扱いません。但し、次の場合はこの限りではありません。",
              ),
            ),
            Container(
              padding: EdgeInsets.only(bottom: 20.0),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text('4.1　法令に基づく場合\n' +
                    '4.2　人の生命、身体又は財産の保護のために必要がある場合であって、本人の同意を得ることが困難であるとき\n' +
                    '4.3　公衆衛生の向上又は児童の健全な育成の推進のために特に必要がある場合であって、本人の同意を得ることが困難であるとき\n' +
                    '4.4　国の機関もしくは地方公共団体又はその委託を受けた者が法令の定める事務を遂行することに対して協力する必要がある場合であって、本人の同意を得ることにより当該事務の遂行に支障を及ぼすおそれがあるとき'),
              ),
            ),
            Container(
              // color: Style.CustomColor.greylight,
              padding: EdgeInsets.all(10),
              decoration: Style.Customstyles.titleCardBoxDecoration,
              child: Row(
                children: <Widget>[Text("5 個人情報の適正な取得")],
              ),
            ),
            SizedBox(height: 10.0),
            Container(
              padding: EdgeInsets.only(bottom: 20.0),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text('5.1　当社は、適正に個人情報を取得し、偽りその他不正の手段により取得しません。\n' +
                    '5.2　当社は、第三者から個人情報の提供を受けるに際しては、個人情報保護委員会規則で定めるところにより、次に掲げる事項の確認を行います。ただし、当該第三者による当該個人情報の提供が第 4 項各号のいずれかに該当する場合又は第 7.1 項各号のいずれかに該当する場合を除きます。\n' +
                    '5.2.(1) 当該第三者の氏名又は名称及び住所、並びに法人の場合はその代表者（法人でない団体で代表者又は管理人の定めのあるものの場合は、その代表者又は管理人）の氏名）\n' +
                    '5.2.(2) 当該第三者による当該個人情報の取得の経緯'),
              ),
            ),
            Container(
              // color: Style.CustomColor.greylight,
              padding: EdgeInsets.all(10),
              decoration: Style.Customstyles.titleCardBoxDecoration,
              child: Row(
                children: <Widget>[Text("6 個人情報の安全管理")],
              ),
            ),
            SizedBox(height: 10.0),
            Container(
              padding: EdgeInsets.only(bottom: 20.0),
              child: Text(
                "当社は、個人情報の紛失、破壊、改ざん及び漏洩などのリスクに対して、個人情報の安全管理が図られるよう、当社の従業員に対し、必要かつ適切な監督を行います。また、当社は、個人情報の取扱いの全部又は一部を委託する場合は、委託先において個人情報の安全管理が図られるよう、必要かつ適切な監督を行います。",
              ),
            ),
            Container(
              // color: Style.CustomColor.greylight,
              padding: EdgeInsets.all(10),
              decoration: Style.Customstyles.titleCardBoxDecoration,
              child: Row(
                children: <Widget>[Text("7 第三者提供")],
              ),
            ),
            SizedBox(height: 10.0),
            Container(
              padding: EdgeInsets.only(bottom: 20.0),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text('7.1 当社は、第 4 項各号のいずれかに該当する場合を除くほか、あらかじめ本人の同意を得ないで、個人情報を第三者に提供しません。但し、次に掲げる場合は上記に定める第三者への提供には該当しません。\n' +
                    '7.1.(1) 利用目的の達成に必要な範囲内において個人情報の取扱いの全部又は一部を委託することに伴って個人情報を提供する場合\n' +
                    '7.1.(2) 合併その他の事由による事業の承継に伴って個人情報が提供される場合\n' +
                    '7.1.(3) 個人情報保護法の定めに基づき共同利用する場合\n' +
                    '7.2　本サービスをご利用いただいた場合、求人への応募やスカウトに興味を示した時点で、当社が求職者会員に対し、「本人に代わって」個人情報を提供することについて同意していただいたものとみなします。求職者会員は、本人の個人情報を、そのサービスを本人に提供するためなどに利用しますが、当社は出店者における個人情報の取扱いについて責任を負うものではありません。\n' +
                    '7.3　当社は、個人情報を第三者に提供したときは、個人情報保護法第 25 条に従い、記録の作成及び保存を行います。\n' +
                    '7.4　当社は、第三者から個人情報の提供を受けるに際しては、個人情報保護法第 26 条に従い、必要な確認を行い、当該確認にかかる記録の作成及び保存を行うものとします。'),
              ),
            ),
            Container(
              // color: Style.CustomColor.greylight,
              padding: EdgeInsets.all(10),
              decoration: Style.Customstyles.titleCardBoxDecoration,
              child: Row(
                children: <Widget>[Text("8 共同利用")],
              ),
            ),
            SizedBox(height: 10.0),
            Container(
              padding: EdgeInsets.only(bottom: 10.0),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                    // Strings.header_eight,
                    '当社は、以下のとおり個人情報を共同利用し、共同利用される個人情報を下記に定める利用者に提供いたします。'),
              ),
            ),
            Container(
              padding: EdgeInsets.only(bottom: 20.0),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text('(1) 共同して利用される個人情報の項目\n' +
                    '氏名、住所、電話番号、メールアドレス及び決済情報\n' +
                    '(2) 共同して利用する者の範囲\n' +
                    'GMO イプシロン株式会社（https://www.epsilon.jp/）\n' +
                    '(3) 利用する者の利用目的\n' +
                    '本サービスの提供のため\n' +
                    '(4) 上記個人情報の管理について責任を有する者の氏名又は名称 \n' +
                    '株式会社 TrustGrowth'),
              ),
            ),
            Container(
              // color: Style.CustomColor.greylight,
              padding: EdgeInsets.all(10),
              decoration: Style.Customstyles.titleCardBoxDecoration,
              child: Row(
                children: <Widget>[Text("9 個人情報の開示")],
              ),
            ),
            SizedBox(height: 10.0),
            Container(
              padding: EdgeInsets.only(bottom: 20.0),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                    // Strings.header_nine,
                    '当社は、本人から、個人情報保護法の定めに基づき個人情報の開示を求められたときは、本人ご自身からのご請求であることを確認の上で、本人に対し、遅滞なく開示を行います（当該個人情報が存在しないときにはその旨を通知いたします。）。但し、個人情報保護法その他の法令により、当社が開示の義務を負わない場合は、この限りではありません。なお、個人情報の開示につきましては、手数料（1 件あたり 300 円）を頂戴しておりますので、あらかじめ御了承ください。'),
              ),
            ),
            Container(
              // color: Style.CustomColor.greylight,
              padding: EdgeInsets.all(10),
              decoration: Style.Customstyles.titleCardBoxDecoration,
              child: Row(
                children: <Widget>[Text("10 個人情報の訂正等")],
              ),
            ),
            SizedBox(height: 10.0),
            Container(
              padding: EdgeInsets.only(bottom: 20.0),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                    // Strings.header_ten,
                    '当社は、本人から、個人情報が真実でないという理由によって、個人情報保護法の定めに基づきその内容の訂正、追加又は削除（以下「訂正等」といいます。）を求められた場合には、本人ご自身からのご請求であることを確認の上で、利用目的の達成に必要な範囲内において、遅滞なく必要な調査を行い、その結果に基づき、個人情報の内容の訂正等を行い、その旨を本人に通知します（訂正等を行わない旨の決定をしたときは、本人に対しその旨を通知いたします。）。但し、個人情報保護法その他の法令により、当社が訂正等の義務を負わない場合は、この限りではありません。'),
              ),
            ),
            Container(
              // color: Style.CustomColor.greylight,
              padding: EdgeInsets.all(10),
              decoration: Style.Customstyles.titleCardBoxDecoration,
              child: Row(
                children: <Widget>[Text("11 個人情報の利用停止等")],
              ),
            ),
            SizedBox(height: 10.0),
            Container(
              padding: EdgeInsets.only(bottom: 20.0),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                    // Strings.header_eleven,
                    '当社は、本人から、本人の個人情報が、あらかじめ公表された利用目的の範囲を超えて取り扱われているという理由又は偽りその他不正の手段により取得されたものであるという理由により、個人情報保護法の定めに基づきその利用の停止又は消去（以下「利用停止等」といいます。）を求められた場合、又は個人情報がご本人の同意なく第三者に提供されているという理由により、個人情報保護法の定めに基づきその提供の停止（以下「提供停止」といいます。）を求められた場合において、そのご請求に理由があることが判明した場合には、本人ご自身からのご請求であることを確認の上で、遅滞なく個人情報の利用停止等又は提供停止を行い、その旨を本人に通知します。但し、個人情報保護法その他の法令により、当社が利用停止等又は提供停止の義務を負わない場合は、この限りではありません。'),
              ),
            ),
            Container(
              // color: Style.CustomColor.greylight,
              padding: EdgeInsets.all(10),
              decoration: Style.Customstyles.titleCardBoxDecoration,
              child: Row(
                children: <Widget>[Text("12 匿名加工情報の取扱い")],
              ),
            ),
            SizedBox(height: 10.0),
            Container(
              padding: EdgeInsets.only(bottom: 20.0),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text('12.1　当社は、匿名加工情報（個人情報保護法第 2 条第 9 項に定めるものを意味し、同法第 2 条第 10 項に定める匿名加工情報データベース等を構成するものに限ります。以下同じ。）を作成するときは、個人情報保護委員会規則で定める基準に従い、個人情報を加工するものとします。\n' +
                    '12.2　当社は、匿名加工情報を作成したときは、個人情報保護委員会規則で定める基準に従い、安全管理のための措置を講じます。' +
                    '12.3　当社は、匿名加工情報を作成したときは、個人情報保護委員会規則で定めるところにより、当該匿名加工情報に含まれる個人に関する情報の項目を公表します。\n' +
                    '12.4　当社は、匿名加工情報（当社が作成したもの及び第三者から提供を受けたものを含みます。以下別段の定めがない限り同様とします。）を第三者に提供するときは、個人情報保護委員会規則で定めるところにより、あらかじめ、第三者に提供される匿名加工情報に含まれる個人に関する情報の項目及びその提供の方法について公表するとともに、当該第三者に対して、当該提供に係る情報が匿名加工情報である旨を明示します。\n' +
                    '12.5　当社は、匿名加工情報を取り扱うに当たっては、匿名加工情報の作成に用いられた個人情報に係る本人を識別するために、(1) 匿名加工情報を他の情報と照合すること、及び (2) 当該個人情報から削除された記述等若しくは個人識別符号又は個人情報保護法第 36 条第 1 項の規定により行われた加工の方法に関する情報を取得すること（(2) は第三者から提供を受けた当該匿名加工情報についてのみ）を行わないものとします。\n' +
                    '12.6　当社は、匿名加工情報の安全管理のために必要かつ適切な措置、匿名加工情報の作成その他の取扱いに関する苦情の処理その他の匿名加工情報の適正な取扱いを確保するために 必要な措置を自ら講じ、かつ、当該措置の内容を公表するよう努めるものとします。'),
              ),
            ),
            Container(
              // color: Style.CustomColor.greylight,
              padding: EdgeInsets.all(10),
              decoration: Style.Customstyles.titleCardBoxDecoration,
              child: Row(
                children: <Widget>[Text("13 Cookie（クッキー）その他の技術の利用")],
              ),
            ),
            SizedBox(height: 10.0),
            Container(
              padding: EdgeInsets.only(bottom: 20.0),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                    '13.1 本サービスは、Cookie 及びこれに類する技術を利用することがあります。これらの技術は、当社による本サービスの利用状況等の把握に役立ち、サービス向上に資するものです。Cookie を無効化されたいユーザーは、ウェブブラウザの設定を変更することにより Cookie を無効化することができます。但し、Cookie を無効化すると、本サービスの一部の機能をご利用いただけなくなる場合があります。\n' +
                        '13.2 本サービスには別紙に示す当社が提携する企業による情報収集モジュールが組み込まれています。これに伴い、当該企業への利用者情報（通信サービス上での行動履歴、統計的なサイト利用情報などを意味しますが、個人識別はされず、匿名データの形で扱われます。）の提供を行います。'),
              ),
            ),
            Container(
              // color: Style.CustomColor.greylight,
              padding: EdgeInsets.all(10),
              decoration: Style.Customstyles.titleCardBoxDecoration,
              child: Row(
                children: <Widget>[Text("14 お問い合わせ")],
              ),
            ),
            SizedBox(height: 10.0),
            Container(
              padding: EdgeInsets.only(bottom: 20.0),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                    '開示等のお申出、ご意見、ご質問、苦情のお申出その他個人情報の取扱いに関するお問い合わせは、以下のメールアドレスにて受け付けております。\n' +
                        '【ユーザー窓口係】\n' +
                        '株式会社 TrustGrowth サポートチーム \n' +
                        'E-mail ： support@borderless-working.jp'),
              ),
            ),
            Container(
              // color: Style.CustomColor.greylight,
              padding: EdgeInsets.all(10),
              decoration: Style.Customstyles.titleCardBoxDecoration,
              child: Row(
                children: <Widget>[Text("15 継続的改善")],
              ),
            ),
            SizedBox(height: 10.0),
            Container(
              padding: EdgeInsets.only(bottom: 20.0),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                    '当社は、個人情報の取扱いに関する運用状況を適宜見直し、継続的な改善に努めるものとし、必要に応じて、本プライバシーポリシーを変更することがあります。'),
              ),
            ),
            Container(
              padding: EdgeInsets.only(bottom: 10.0),
              child: Align(
                alignment: Alignment.bottomRight,
                child: Text('令和 2 年 12 月 1 日制定'),
              ),
            )
          ],
        ),
      ),
    );
  }
}
