import React, { useState } from 'react';
import { Container, Card, CardContent, Button, Typography, FormControl, TextField } from '@mui/material';
import { ConnectButton } from '@rainbow-me/rainbowkit';
import { useAccount, useContractRead, usePrepareContractWrite, useContractWrite } from 'wagmi';
import { parseEther } from 'viem';

import TokenExampleAbi from '../assets/tokenpayment/TokenExample.json';
import TokenPaymentAbi from '../assets/tokenpayment/TokenPayment.json';

function TokenPaymentPage() {
    const [textMetadata, setTextMetadata] = useState('');
    const handleMetadata = (event: any) => setTextMetadata(event.target.value);
    const [textPrice, setTextPrice] = useState('');
    const handlePrice = (event: any) => setTextPrice(event.target.value);
    const [textId, setTextId] = useState('');
    const handleId = (event: any) => setTextId(String(event.target.value));

    const { address } = useAccount();
    const contractAddressTokenExample = '0x1a1b296ba15DaF6f2CC91D173aF1dbD7cE1723EA';
    const contractAddressTokenPayment = '0x6f38dFA8563B32325eDE9dcF48AaCBbD318d9459';
    const { data } = useContractRead({
        address: contractAddressTokenExample,
        abi: TokenExampleAbi as any,
        functionName: 'allowance',
        args: [address as any, contractAddressTokenPayment]
    });
    const { config: configApprove } = usePrepareContractWrite({
        address: contractAddressTokenExample,
        abi: TokenExampleAbi,
        functionName: 'approve',
        args: [contractAddressTokenPayment, '1000000000000000000000']
    });
    const { write: writeApprove } = useContractWrite(configApprove);

    const { config: configSell } = usePrepareContractWrite({
        address: contractAddressTokenPayment,
        abi: TokenPaymentAbi,
        functionName: 'sell',
        args: [textMetadata, contractAddressTokenExample, parseEther(textPrice)]
    });
    const { write: writeSell } = useContractWrite(configSell);

    const { config: configPurchase } = usePrepareContractWrite({
        address: contractAddressTokenPayment,
        abi: TokenPaymentAbi,
        functionName: 'purchase',
        account: address,
        args: [textId]
    });
    const { write: writePurchase, isLoading, isSuccess, isError, error } = useContractWrite(configPurchase);
    console.log({ data });
    return (
        <Container fixed>
        <ConnectButton />
            <Card>
                <CardContent>
                    <Typography gutterBottom variant="h5" component="div">
                        Token Payment (Sell)
                    </Typography>
                </CardContent>
                <CardContent>
                    <FormControl>
                        <TextField
                            value={textMetadata}
                            onChange={handleMetadata}
                            label="Input Metadata" type="text" size='medium' />
                        <TextField
                            value={textPrice}
                            onChange={handlePrice}
                            label="Input Price" type="text" size='medium' />
                        <Button
                            onClick={writeSell}
                            disabled={textMetadata && textPrice ? false : true}
                            variant="contained">Submit</Button>
                    </FormControl>
                </CardContent>
            </Card>
            <Card>
                <CardContent>
                    <Typography gutterBottom variant="h5" component="div">
                        Token Payment (Buy)
                    </Typography>
                </CardContent>
                <CardContent>
                    <FormControl>
                        <TextField
                            value={textId}
                            onChange={handleId}
                            label="Input ID" type="text" size='medium' />
                        <Button variant="contained"
                        disabled={data && Number(data) == 0 ? false : true}
                        onClick={writeApprove}
                        >Set Allowance</Button><br/>
                        <Button variant="contained"
                        disabled={data && Number(data) > 0 && textId ? false : true}
                        onClick={writePurchase}
                        >Submit</Button>
                    </FormControl>
                </CardContent>
            </Card>
        </Container>
    );
}

export { TokenPaymentPage };